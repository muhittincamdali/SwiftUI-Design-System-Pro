import CoreGraphics
import Foundation

/// A coarse description of a rendered image: its size and the average color
/// of each cell in a fixed grid. Comparing fingerprints catches changed
/// colors, missing components and layout shifts, while tolerating the small
/// anti-aliasing differences between OS and Xcode versions that make exact
/// pixel snapshots fail.
struct RenderFingerprint: Codable, Equatable {
    static let columns = 8
    static let rows = 8

    let width: Int
    let height: Int
    /// Row-major average colors as `RRGGBB` hex, `columns * rows` entries.
    let cells: [String]

    @MainActor
    init(image: CGImage) {
        let bytes = pixels(of: image)
        var cells: [String] = []
        for row in 0..<Self.rows {
            let top = row * image.height / Self.rows
            let bottom = max(top + 1, (row + 1) * image.height / Self.rows)
            for column in 0..<Self.columns {
                let left = column * image.width / Self.columns
                let right = max(left + 1, (column + 1) * image.width / Self.columns)
                var sum = [0.0, 0.0, 0.0]
                for y in top..<bottom {
                    for x in left..<right {
                        let offset = (y * image.width + x) * 4
                        for channel in 0..<3 {
                            sum[channel] += Double(bytes[offset + channel])
                        }
                    }
                }
                let count = Double((bottom - top) * (right - left))
                cells.append(sum.map { String(format: "%02X", Int(($0 / count).rounded())) }.joined())
            }
        }
        self.width = image.width
        self.height = image.height
        self.cells = cells
    }

    /// Differences larger than the tolerances, as readable messages.
    func differences(
        from reference: RenderFingerprint,
        colorTolerance: Double,
        sizeTolerance: Int
    ) -> [String] {
        var messages: [String] = []
        if abs(width - reference.width) > sizeTolerance || abs(height - reference.height) > sizeTolerance {
            messages.append("size \(width)x\(height), reference \(reference.width)x\(reference.height)")
        }
        for (index, (cell, expected)) in zip(cells, reference.cells).enumerated() {
            let delta = zip(Self.components(cell), Self.components(expected)).map { abs($0 - $1) }.max() ?? 1
            if delta > colorTolerance {
                let row = index / Self.columns, column = index % Self.columns
                messages.append("cell (\(column), \(row)) \(cell), reference \(expected)")
            }
        }
        return messages
    }

    /// The red, green and blue components of an `RRGGBB` string in 0...1.
    private static func components(_ hex: String) -> [Double] {
        guard let value = UInt32(hex, radix: 16), hex.count == 6 else { return [] }
        return [value >> 16, value >> 8 & 0xFF, value & 0xFF].map { Double($0) / 255 }
    }
}
