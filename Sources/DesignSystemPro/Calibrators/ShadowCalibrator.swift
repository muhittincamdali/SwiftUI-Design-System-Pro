import SwiftUI

/// SwiftUI-Design-System-Pro: Adaptive Shadow Calibrator.
/// 
/// Dynamically adjusts shadow properties based on the color scheme 
/// (Light/Dark) to maintain depth without sacrificing contrast.
public struct ShadowCalibrator: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    public let lightOpacity: Double
    public let darkOpacity: Double
    public let radius: CGFloat
    
    public init(lightOpacity: Double = 0.15, darkOpacity: Double = 0.4, radius: CGFloat = 10) {
        self.lightOpacity = lightOpacity
        self.darkOpacity = darkOpacity
        self.radius = radius
    }
    
    public func body(content: Content) -> some View {
        content
            .shadow(
                color: Color.black.opacity(colorScheme == .dark ? darkOpacity : lightOpacity),
                radius: radius,
                x: 0,
                y: radius / 2
            )
    }
}

public extension View {
    /// Applies an adaptive, calibrated shadow.
    func adaptiveShadow(radius: CGFloat = 10) -> some View {
        self.modifier(ShadowCalibrator(radius: radius))
    }
}
