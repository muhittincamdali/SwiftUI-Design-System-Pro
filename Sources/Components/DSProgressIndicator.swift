import SwiftUI

public struct DSProgressIndicator: View {
    public let progress: Double
    public let style: DSProgressIndicatorStyle
    public let size: DSProgressIndicatorSize
    public let showPercentage: Bool
    public let animated: Bool
    
    @State private var animatedProgress: Double = 0
    
    public init(
        progress: Double,
        style: DSProgressIndicatorStyle = .linear,
        size: DSProgressIndicatorSize = .medium,
        showPercentage: Bool = false,
        animated: Bool = true
    ) {
        self.progress = max(0, min(1, progress))
        self.style = style
        self.size = size
        self.showPercentage = showPercentage
        self.animated = animated
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            switch style {
            case .linear:
                linearProgressView
            case .circular:
                circularProgressView
            case .determinate:
                determinateProgressView
            case .indeterminate:
                indeterminateProgressView
            }
            
            if showPercentage {
                Text("\(Int(animatedProgress * 100))%")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(style.textColor)
            }
        }
        .onAppear {
            if animated {
                withAnimation(.easeInOut(duration: 1.0)) {
                    animatedProgress = progress
                }
            } else {
                animatedProgress = progress
            }
        }
        .onChange(of: progress) { newProgress in
            if animated {
                withAnimation(.easeInOut(duration: 0.5)) {
                    animatedProgress = newProgress
                }
            } else {
                animatedProgress = newProgress
            }
        }
    }
    
    private var linearProgressView: some View {
        VStack(spacing: 4) {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: size.cornerRadius)
                        .fill(style.trackColor(for: colorScheme))
                        .frame(height: size.height)
                    
                    RoundedRectangle(cornerRadius: size.cornerRadius)
                        .fill(style.progressColor)
                        .frame(width: geometry.size.width * animatedProgress, height: size.height)
                        .animation(.easeInOut(duration: 0.3), value: animatedProgress)
                }
            }
            .frame(height: size.height)
        }
    }
    
    private var circularProgressView: some View {
        ZStack {
            Circle()
                .stroke(style.trackColor(for: colorScheme), lineWidth: size.strokeWidth)
                .frame(width: size.diameter, height: size.diameter)
            
            Circle()
                .trim(from: 0, to: animatedProgress)
                .stroke(style.progressColor, style: StrokeStyle(lineWidth: size.strokeWidth, lineCap: .round))
                .frame(width: size.diameter, height: size.diameter)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.3), value: animatedProgress)
        }
    }
    
    private var determinateProgressView: some View {
        HStack(spacing: 8) {
            circularProgressView
            
            if showPercentage {
                Text("\(Int(animatedProgress * 100))%")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(style.textColor)
            }
        }
    }
    
    private var indeterminateProgressView: some View {
        ZStack {
            Circle()
                .stroke(style.trackColor(for: colorScheme), lineWidth: size.strokeWidth)
                .frame(width: size.diameter, height: size.diameter)
            
            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(style.progressColor, style: StrokeStyle(lineWidth: size.strokeWidth, lineCap: .round))
                .frame(width: size.diameter, height: size.diameter)
                .rotationEffect(.degrees(-90))
                .rotationEffect(.degrees(360 * animatedProgress))
                .animation(.linear(duration: 1.0).repeatForever(autoreverses: false), value: animatedProgress)
        }
        .onAppear {
            animatedProgress = 1.0
        }
    }
    
    @Environment(\.colorScheme) private var colorScheme
}

public enum DSProgressIndicatorStyle {
    case linear
    case circular
    case determinate
    case indeterminate
}

public enum DSProgressIndicatorSize {
    case small, medium, large
    
    public var height: CGFloat {
        switch self {
        case .small: return 4
        case .medium: return 6
        case .large: return 8
        }
    }
    
    public var cornerRadius: CGFloat {
        switch self {
        case .small: return 2
        case .medium: return 3
        case .large: return 4
        }
    }
    
    public var diameter: CGFloat {
        switch self {
        case .small: return 24
        case .medium: return 32
        case .large: return 48
        }
    }
    
    public var strokeWidth: CGFloat {
        switch self {
        case .small: return 2
        case .medium: return 3
        case .large: return 4
        }
    }
}

public struct DSProgressIndicatorStyle {
    public let progressColor: Color
    public let trackColor: (ColorScheme) -> Color
    public let textColor: Color
    
    public init(
        progressColor: Color,
        trackColor: @escaping (ColorScheme) -> Color,
        textColor: Color
    ) {
        self.progressColor = progressColor
        self.trackColor = trackColor
        self.textColor = textColor
    }
    
    public static let primary = DSProgressIndicatorStyle(
        progressColor: .blue,
        trackColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6)
        },
        textColor: .primary
    )
    
    public static let success = DSProgressIndicatorStyle(
        progressColor: .green,
        trackColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6)
        },
        textColor: .primary
    )
    
    public static let warning = DSProgressIndicatorStyle(
        progressColor: .orange,
        trackColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6)
        },
        textColor: .primary
    )
    
    public static let error = DSProgressIndicatorStyle(
        progressColor: .red,
        trackColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6)
        },
        textColor: .primary
    )
} 