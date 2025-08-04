import SwiftUI

/// A comprehensive chart component with multiple chart types and customizable styling
public struct DSChart: View {
    
    // MARK: - Properties
    
    /// The chart data points
    public let dataPoints: [DSChartDataPoint]
    
    /// The type of chart to display
    public let chartType: DSChartType
    
    /// Chart styling configuration
    public let style: DSChartStyle
    
    /// Whether to show grid lines
    public let showGrid: Bool
    
    /// Whether to show data labels
    public let showLabels: Bool
    
    /// Animation configuration
    public let animation: Animation
    
    // MARK: - Initializers
    
    /// Creates a chart with the specified configuration
    /// - Parameters:
    ///   - dataPoints: Array of data points
    ///   - chartType: Type of chart to display
    ///   - style: Chart styling
    ///   - showGrid: Whether to show grid lines
    ///   - showLabels: Whether to show data labels
    ///   - animation: Animation for data changes
    public init(
        dataPoints: [DSChartDataPoint],
        chartType: DSChartType,
        style: DSChartStyle = .default,
        showGrid: Bool = true,
        showLabels: Bool = false,
        animation: Animation = .easeInOut(duration: 0.8)
    ) {
        self.dataPoints = dataPoints
        self.chartType = chartType
        self.style = style
        self.showGrid = showGrid
        self.showLabels = showLabels
        self.animation = animation
    }
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Grid lines
                if showGrid {
                    DSChartGrid(
                        dataPoints: dataPoints,
                        style: style.gridStyle
                    )
                }
                
                // Chart content
                chartContent(in: geometry)
            }
        }
        .aspectRatio(style.aspectRatio, contentMode: .fit)
        .animation(animation, value: dataPoints)
    }
    
    // MARK: - Private Views
    
    @ViewBuilder
    private func chartContent(in geometry: GeometryProxy) -> some View {
        switch chartType {
        case .line:
            DSLineChart(
                dataPoints: dataPoints,
                style: style,
                showLabels: showLabels,
                geometry: geometry
            )
        case .bar:
            DSBarChart(
                dataPoints: dataPoints,
                style: style,
                showLabels: showLabels,
                geometry: geometry
            )
        case .pie:
            DSPieChart(
                dataPoints: dataPoints,
                style: style,
                showLabels: showLabels,
                geometry: geometry
            )
        case .area:
            DSAreaChart(
                dataPoints: dataPoints,
                style: style,
                showLabels: showLabels,
                geometry: geometry
            )
        }
    }
}

// MARK: - Line Chart

/// Line chart implementation
private struct DSLineChart: View {
    
    // MARK: - Properties
    
    public let dataPoints: [DSChartDataPoint]
    public let style: DSChartStyle
    public let showLabels: Bool
    public let geometry: GeometryProxy
    
    // MARK: - Body
    
    public var body: some View {
        Path { path in
            guard !dataPoints.isEmpty else { return }
            
            let points = normalizedPoints()
            path.move(to: points[0])
            
            for index in 1..<points.count {
                path.addLine(to: points[index])
            }
        }
        .stroke(style.lineColor, lineWidth: style.lineWidth)
        .animation(.easeInOut(duration: 0.8), value: dataPoints)
        
        // Data points
        ForEach(Array(dataPoints.enumerated()), id: \.offset) { index, point in
            Circle()
                .fill(style.pointColor)
                .frame(width: style.pointSize, height: style.pointSize)
                .position(normalizedPoint(for: point))
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: dataPoints)
        }
        
        // Labels
        if showLabels {
            ForEach(Array(dataPoints.enumerated()), id: \.offset) { index, point in
                Text(point.label)
                    .font(style.labelFont)
                    .foregroundColor(style.labelColor)
                    .position(
                        x: normalizedPoint(for: point).x,
                        y: normalizedPoint(for: point).y - 20
                    )
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func normalizedPoints() -> [CGPoint] {
        dataPoints.map { normalizedPoint(for: $0) }
    }
    
    private func normalizedPoint(for dataPoint: DSChartDataPoint) -> CGPoint {
        let maxValue = dataPoints.map { $0.value }.max() ?? 1
        let x = (dataPoint.x / CGFloat(dataPoints.count - 1)) * geometry.size.width
        let y = geometry.size.height - (dataPoint.value / maxValue) * geometry.size.height
        return CGPoint(x: x, y: y)
    }
}

// MARK: - Bar Chart

/// Bar chart implementation
private struct DSBarChart: View {
    
    // MARK: - Properties
    
    public let dataPoints: [DSChartDataPoint]
    public let style: DSChartStyle
    public let showLabels: Bool
    public let geometry: GeometryProxy
    
    // MARK: - Body
    
    public var body: some View {
        HStack(spacing: style.barSpacing) {
            ForEach(Array(dataPoints.enumerated()), id: \.offset) { index, point in
                VStack {
                    // Bar
                    Rectangle()
                        .fill(style.barColor)
                        .frame(width: barWidth(), height: barHeight(for: point))
                        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: dataPoints)
                    
                    // Label
                    if showLabels {
                        Text(point.label)
                            .font(style.labelFont)
                            .foregroundColor(style.labelColor)
                            .rotationEffect(.degrees(-45))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Private Methods
    
    private func barWidth() -> CGFloat {
        let availableWidth = geometry.size.width - (CGFloat(dataPoints.count - 1) * style.barSpacing)
        return availableWidth / CGFloat(dataPoints.count)
    }
    
    private func barHeight(for dataPoint: DSChartDataPoint) -> CGFloat {
        let maxValue = dataPoints.map { $0.value }.max() ?? 1
        return (dataPoint.value / maxValue) * geometry.size.height
    }
}

// MARK: - Pie Chart

/// Pie chart implementation
private struct DSPieChart: View {
    
    // MARK: - Properties
    
    public let dataPoints: [DSChartDataPoint]
    public let style: DSChartStyle
    public let showLabels: Bool
    public let geometry: GeometryProxy
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            // Pie slices
            ForEach(Array(dataPoints.enumerated()), id: \.offset) { index, point in
                DSPieSlice(
                    dataPoint: point,
                    total: totalValue(),
                    startAngle: startAngle(for: index),
                    style: style
                )
            }
            
            // Center label
            if showLabels {
                Text("Total: \(String(format: "%.1f", totalValue()))")
                    .font(style.labelFont)
                    .foregroundColor(style.labelColor)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func totalValue() -> Double {
        dataPoints.reduce(0) { $0 + $1.value }
    }
    
    private func startAngle(for index: Int) -> Double {
        let previousValues = dataPoints.prefix(index).reduce(0) { $0 + $1.value }
        return (previousValues / totalValue()) * 360
    }
}

// MARK: - Pie Slice

/// Individual pie slice component
private struct DSPieSlice: View {
    
    // MARK: - Properties
    
    public let dataPoint: DSChartDataPoint
    public let total: Double
    public let startAngle: Double
    public let style: DSChartStyle
    
    // MARK: - Body
    
    public var body: some View {
        Path { path in
            let center = CGPoint(x: 0, y: 0)
            let radius: CGFloat = 100
            let endAngle = startAngle + (dataPoint.value / total) * 360
            
            path.move(to: center)
            path.addArc(
                center: center,
                radius: radius,
                startAngle: .degrees(startAngle),
                endAngle: .degrees(endAngle),
                clockwise: false
            )
            path.closeSubpath()
        }
        .fill(style.pieColors[dataPoint.colorIndex % style.pieColors.count])
        .animation(.easeInOut(duration: 0.8), value: dataPoint.value)
    }
}

// MARK: - Area Chart

/// Area chart implementation
private struct DSAreaChart: View {
    
    // MARK: - Properties
    
    public let dataPoints: [DSChartDataPoint]
    public let style: DSChartStyle
    public let showLabels: Bool
    public let geometry: GeometryProxy
    
    // MARK: - Body
    
    public var body: some View {
        Path { path in
            guard !dataPoints.isEmpty else { return }
            
            let points = normalizedPoints()
            path.move(to: CGPoint(x: points[0].x, y: geometry.size.height))
            path.addLine(to: points[0])
            
            for index in 1..<points.count {
                path.addLine(to: points[index])
            }
            
            path.addLine(to: CGPoint(x: points.last?.x ?? 0, y: geometry.size.height))
            path.closeSubpath()
        }
        .fill(style.areaColor.opacity(0.3))
        .animation(.easeInOut(duration: 0.8), value: dataPoints)
    }
    
    // MARK: - Private Methods
    
    private func normalizedPoints() -> [CGPoint] {
        dataPoints.map { normalizedPoint(for: $0) }
    }
    
    private func normalizedPoint(for dataPoint: DSChartDataPoint) -> CGPoint {
        let maxValue = dataPoints.map { $0.value }.max() ?? 1
        let x = (dataPoint.x / CGFloat(dataPoints.count - 1)) * geometry.size.width
        let y = geometry.size.height - (dataPoint.value / maxValue) * geometry.size.height
        return CGPoint(x: x, y: y)
    }
}

// MARK: - Chart Grid

/// Grid lines for charts
private struct DSChartGrid: View {
    
    // MARK: - Properties
    
    public let dataPoints: [DSChartDataPoint]
    public let style: DSChartGridStyle
    
    // MARK: - Body
    
    public var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<style.horizontalLines, id: \.self) { index in
                Divider()
                    .background(style.gridColor)
                    .opacity(style.gridOpacity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Supporting Types

/// Data point for charts
public struct DSChartDataPoint {
    /// The x-coordinate value
    public let x: CGFloat
    
    /// The y-coordinate value
    public let value: Double
    
    /// The label for this data point
    public let label: String
    
    /// Color index for pie charts
    public let colorIndex: Int
    
    /// Creates a chart data point
    /// - Parameters:
    ///   - x: X-coordinate value
    ///   - value: Y-coordinate value
    ///   - label: Data point label
    ///   - colorIndex: Color index for pie charts
    public init(x: CGFloat, value: Double, label: String, colorIndex: Int = 0) {
        self.x = x
        self.value = value
        self.label = label
        self.colorIndex = colorIndex
    }
}

/// Chart types
public enum DSChartType {
    case line
    case bar
    case pie
    case area
}

/// Chart styling configuration
public struct DSChartStyle {
    /// Line color for line charts
    public let lineColor: Color
    
    /// Line width for line charts
    public let lineWidth: CGFloat
    
    /// Point color for line charts
    public let pointColor: Color
    
    /// Point size for line charts
    public let pointSize: CGFloat
    
    /// Bar color for bar charts
    public let barColor: Color
    
    /// Bar spacing for bar charts
    public let barSpacing: CGFloat
    
    /// Area color for area charts
    public let areaColor: Color
    
    /// Pie chart colors
    public let pieColors: [Color]
    
    /// Label font
    public let labelFont: Font
    
    /// Label color
    public let labelColor: Color
    
    /// Chart aspect ratio
    public let aspectRatio: CGFloat
    
    /// Grid styling
    public let gridStyle: DSChartGridStyle
    
    /// Creates a chart style
    /// - Parameters:
    ///   - lineColor: Line color
    ///   - lineWidth: Line width
    ///   - pointColor: Point color
    ///   - pointSize: Point size
    ///   - barColor: Bar color
    ///   - barSpacing: Bar spacing
    ///   - areaColor: Area color
    ///   - pieColors: Pie chart colors
    ///   - labelFont: Label font
    ///   - labelColor: Label color
    ///   - aspectRatio: Aspect ratio
    ///   - gridStyle: Grid styling
    public init(
        lineColor: Color,
        lineWidth: CGFloat,
        pointColor: Color,
        pointSize: CGFloat,
        barColor: Color,
        barSpacing: CGFloat,
        areaColor: Color,
        pieColors: [Color],
        labelFont: Font,
        labelColor: Color,
        aspectRatio: CGFloat,
        gridStyle: DSChartGridStyle
    ) {
        self.lineColor = lineColor
        self.lineWidth = lineWidth
        self.pointColor = pointColor
        self.pointSize = pointSize
        self.barColor = barColor
        self.barSpacing = barSpacing
        self.areaColor = areaColor
        self.pieColors = pieColors
        self.labelFont = labelFont
        self.labelColor = labelColor
        self.aspectRatio = aspectRatio
        self.gridStyle = gridStyle
    }
    
    /// Default chart style
    public static let `default` = DSChartStyle(
        lineColor: .blue,
        lineWidth: 2,
        pointColor: .blue,
        pointSize: 6,
        barColor: .blue,
        barSpacing: 8,
        areaColor: .blue,
        pieColors: [.blue, .green, .orange, .red, .purple],
        labelFont: .caption,
        labelColor: .secondary,
        aspectRatio: 16/9,
        gridStyle: .default
    )
}

/// Grid styling for charts
public struct DSChartGridStyle {
    /// Grid color
    public let gridColor: Color
    
    /// Grid opacity
    public let gridOpacity: Double
    
    /// Number of horizontal lines
    public let horizontalLines: Int
    
    /// Creates a grid style
    /// - Parameters:
    ///   - gridColor: Grid color
    ///   - gridOpacity: Grid opacity
    ///   - horizontalLines: Number of horizontal lines
    public init(gridColor: Color, gridOpacity: Double, horizontalLines: Int) {
        self.gridColor = gridColor
        self.gridOpacity = gridOpacity
        self.horizontalLines = horizontalLines
    }
    
    /// Default grid style
    public static let `default` = DSChartGridStyle(
        gridColor: .gray,
        gridOpacity: 0.3,
        horizontalLines: 5
    )
}

// MARK: - Preview

struct DSChart_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            DSChart(
                dataPoints: [
                    DSChartDataPoint(x: 0, value: 10, label: "Jan"),
                    DSChartDataPoint(x: 1, value: 20, label: "Feb"),
                    DSChartDataPoint(x: 2, value: 15, label: "Mar"),
                    DSChartDataPoint(x: 3, value: 30, label: "Apr")
                ],
                chartType: .line,
                showLabels: true
            )
            .frame(height: 200)
            
            DSChart(
                dataPoints: [
                    DSChartDataPoint(x: 0, value: 10, label: "A"),
                    DSChartDataPoint(x: 1, value: 20, label: "B"),
                    DSChartDataPoint(x: 2, value: 15, label: "C")
                ],
                chartType: .bar,
                showLabels: true
            )
            .frame(height: 200)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
} 