import Testing
@testable import DesignSystemPro

@Suite("Component logic")
struct ComponentLogicTests {
    @Test("OTP input keeps ASCII digits up to the length", arguments: [
        ("123456", 6, "123456"),
        ("12a3-45 678", 6, "123456"),
        ("98", 6, "98"),
        ("١٢٣٤", 4, ""),
        ("1234", 0, "")
    ])
    func otpSanitize(input: String, length: Int, expected: String) {
        #expect(DSOTPField.sanitize(input, length: length) == expected)
    }

    @Test func otpDigitLookupIsBoundsSafe() {
        #expect(DSOTPField.digit(in: "42", at: 1) == "2")
        #expect(DSOTPField.digit(in: "42", at: 2).isEmpty)
        #expect(DSOTPField.digit(in: "42", at: -1).isEmpty)
    }

    @Test("Avatar initials use the first two words", arguments: [
        ("Ada Lovelace", "AL"),
        ("  grace   brewster  hopper ", "GB"),
        ("linus", "L"),
        ("émile zola", "ÉZ"),
        ("", "")
    ])
    func avatarInitials(name: String, expected: String) {
        #expect(DSAvatar.initials(from: name) == expected)
    }

    @Test func avatarPaletteIndexIsStableAndInRange() {
        let name = "Ada Lovelace"
        let index = DSAvatar.paletteIndex(for: name, paletteSize: 8)
        #expect(index == DSAvatar.paletteIndex(for: name, paletteSize: 8))
        #expect((0..<8).contains(index))

        let longName = String(repeating: "\u{10FFFF}", count: 10_000)
        #expect((0..<8).contains(DSAvatar.paletteIndex(for: longName, paletteSize: 8)))
    }

    @Test("Counter badge caps at maxCount", arguments: [
        (5, 99, "5"),
        (99, 99, "99"),
        (100, 99, "99+"),
        (12, 9, "9+")
    ])
    func counterBadgeText(count: Int, maxCount: Int, expected: String) {
        #expect(DSCounterBadge.displayText(count: count, maxCount: maxCount) == expected)
    }
}
