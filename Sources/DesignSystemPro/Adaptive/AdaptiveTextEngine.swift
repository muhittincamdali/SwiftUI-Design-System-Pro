import SwiftUI

/// SwiftUI-Design-System-Pro: Adaptive Typography Engine.
/// 
/// Fine-tunes tracking and weight based on dynamic type sizes to ensure 
/// high-integrity legibility across all user settings.
public struct AdaptiveTextEngine: ViewModifier {
    @Environment(\.dynamicTypeSize) private var typeSize
    
    public let baseFont: Font
    
    public init(font: Font) {
        self.baseFont = font
    }
    
    public func body(content: Content) -> some View {
        content
            .font(baseFont)
            .tracking(typeSize.isAccessibilitySize ? -0.5 : 0)
            .fontWeight(typeSize.isAccessibilitySize ? .medium : .regular)
    }
}

public extension View {
    /// Applies high-integrity adaptive typography settings.
    func adaptiveText(font: Font) -> some View {
        self.modifier(AdaptiveTextEngine(font: font))
    }
}
