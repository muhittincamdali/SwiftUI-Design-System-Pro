// AnimationTokens.swift
// DesignSystemPro
//
// Production-grade animation system with timing curves,
// durations, and semantic animation presets.

import SwiftUI

// MARK: - Duration Tokens

/// Animation duration scale in seconds
public enum DurationScale: Double, CaseIterable, Sendable {
    /// Instant (0ms) - No animation
    case instant = 0
    
    /// Ultra fast (50ms) - Micro-interactions
    case ultraFast = 0.05
    
    /// Extra fast (100ms) - Small state changes
    case extraFast = 0.1
    
    /// Fast (150ms) - Button feedback
    case fast = 0.15
    
    /// Normal (200ms) - Standard transitions
    case normal = 0.2
    
    /// Medium (300ms) - Modal enter/exit
    case medium = 0.3
    
    /// Slow (400ms) - Page transitions
    case slow = 0.4
    
    /// Extra slow (500ms) - Complex animations
    case extraSlow = 0.5
    
    /// Ultra slow (700ms) - Dramatic effects
    case ultraSlow = 0.7
    
    /// Glacial (1000ms) - Very slow, intentional
    case glacial = 1.0
}

// MARK: - Easing Curves

/// Standard easing curves based on Material Design and Apple HIG
public enum EasingCurve: Sendable {
    /// Linear - constant speed
    case linear
    
    /// Ease In - starts slow, accelerates
    case easeIn
    
    /// Ease Out - starts fast, decelerates (most common)
    case easeOut
    
    /// Ease In Out - starts slow, speeds up, slows down
    case easeInOut
    
    /// Emphasized Ease In - more pronounced acceleration
    case emphasizedIn
    
    /// Emphasized Ease Out - more pronounced deceleration
    case emphasizedOut
    
    /// Emphasized Ease In Out - dramatic curve
    case emphasizedInOut
    
    /// Spring - natural bounce
    case spring
    
    /// Bounce - overshoots and settles
    case bounce
    
    /// Snappy - quick with slight overshoot
    case snappy
    
    /// Custom cubic bezier
    case custom(c1x: Double, c1y: Double, c2x: Double, c2y: Double)
    
    public var animation: Animation {
        switch self {
        case .linear:
            return .linear
        case .easeIn:
            return .easeIn
        case .easeOut:
            return .easeOut
        case .easeInOut:
            return .easeInOut
        case .emphasizedIn:
            return .timingCurve(0.3, 0, 0.8, 0.15)
        case .emphasizedOut:
            return .timingCurve(0.05, 0.7, 0.1, 1.0)
        case .emphasizedInOut:
            return .timingCurve(0.4, 0.0, 0.2, 1.0)
        case .spring:
            return .spring(response: 0.5, dampingFraction: 0.7)
        case .bounce:
            return .spring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.25)
        case .snappy:
            return .spring(response: 0.35, dampingFraction: 0.85)
        case .custom(let c1x, let c1y, let c2x, let c2y):
            return .timingCurve(c1x, c1y, c2x, c2y)
        }
    }
}

// MARK: - Animation Token

public struct AnimationToken: Sendable {
    public let duration: DurationScale
    public let easing: EasingCurve
    public let delay: Double
    
    public init(
        duration: DurationScale = .normal,
        easing: EasingCurve = .easeOut,
        delay: Double = 0
    ) {
        self.duration = duration
        self.easing = easing
        self.delay = delay
    }
    
    public var animation: Animation {
        easing.animation
            .speed(1.0 / duration.rawValue * 0.2) // Normalize to duration
            .delay(delay)
    }
    
    /// Create SwiftUI animation with explicit duration
    public var swiftUIAnimation: Animation {
        switch easing {
        case .spring, .bounce, .snappy:
            return easing.animation.delay(delay)
        default:
            return easing.animation
                .speed(0.2 / duration.rawValue) // Inverse to match duration
                .delay(delay)
        }
    }
}

// MARK: - Animation Tokens Namespace

public enum AnimationTokens {
    
    // MARK: - Micro Interactions
    public enum Micro {
        /// Button press feedback
        public static let buttonPress = AnimationToken(
            duration: .ultraFast,
            easing: .easeOut
        )
        
        /// Toggle switch
        public static let toggle = AnimationToken(
            duration: .fast,
            easing: .spring
        )
        
        /// Checkbox check
        public static let checkbox = AnimationToken(
            duration: .fast,
            easing: .snappy
        )
        
        /// Ripple effect
        public static let ripple = AnimationToken(
            duration: .medium,
            easing: .easeOut
        )
        
        /// Hover state
        public static let hover = AnimationToken(
            duration: .extraFast,
            easing: .easeOut
        )
        
        /// Focus ring
        public static let focus = AnimationToken(
            duration: .fast,
            easing: .easeInOut
        )
    }
    
    // MARK: - Component Transitions
    public enum Component {
        /// Fade in/out
        public static let fade = AnimationToken(
            duration: .normal,
            easing: .easeInOut
        )
        
        /// Scale up/down
        public static let scale = AnimationToken(
            duration: .fast,
            easing: .spring
        )
        
        /// Slide in/out
        public static let slide = AnimationToken(
            duration: .medium,
            easing: .emphasizedOut
        )
        
        /// Expand/collapse
        public static let expand = AnimationToken(
            duration: .medium,
            easing: .easeInOut
        )
        
        /// Card flip
        public static let flip = AnimationToken(
            duration: .slow,
            easing: .easeInOut
        )
        
        /// Skeleton shimmer
        public static let shimmer = AnimationToken(
            duration: .glacial,
            easing: .linear
        )
    }
    
    // MARK: - Page/Modal Transitions
    public enum Page {
        /// Modal presentation
        public static let modalEnter = AnimationToken(
            duration: .medium,
            easing: .spring
        )
        
        /// Modal dismissal
        public static let modalExit = AnimationToken(
            duration: .normal,
            easing: .easeIn
        )
        
        /// Sheet slide up
        public static let sheetEnter = AnimationToken(
            duration: .medium,
            easing: .emphasizedOut
        )
        
        /// Sheet slide down
        public static let sheetExit = AnimationToken(
            duration: .normal,
            easing: .emphasizedIn
        )
        
        /// Page push
        public static let push = AnimationToken(
            duration: .medium,
            easing: .emphasizedOut
        )
        
        /// Page pop
        public static let pop = AnimationToken(
            duration: .medium,
            easing: .emphasizedIn
        )
        
        /// Crossfade between pages
        public static let crossfade = AnimationToken(
            duration: .normal,
            easing: .easeInOut
        )
    }
    
    // MARK: - Feedback
    public enum Feedback {
        /// Success animation
        public static let success = AnimationToken(
            duration: .slow,
            easing: .bounce
        )
        
        /// Error shake
        public static let error = AnimationToken(
            duration: .fast,
            easing: .spring
        )
        
        /// Warning pulse
        public static let warning = AnimationToken(
            duration: .medium,
            easing: .easeInOut
        )
        
        /// Loading spinner
        public static let loading = AnimationToken(
            duration: .glacial,
            easing: .linear
        )
    }
    
    // MARK: - Layout
    public enum Layout {
        /// List item reorder
        public static let reorder = AnimationToken(
            duration: .medium,
            easing: .spring
        )
        
        /// Grid layout change
        public static let gridChange = AnimationToken(
            duration: .medium,
            easing: .easeInOut
        )
        
        /// Size transition
        public static let resize = AnimationToken(
            duration: .normal,
            easing: .easeOut
        )
    }
}

// MARK: - Spring Configurations

public enum SpringConfig: Sendable {
    /// Gentle spring - smooth, no overshoot
    case gentle
    
    /// Default spring - slight bounce
    case `default`
    
    /// Bouncy spring - noticeable bounce
    case bouncy
    
    /// Stiff spring - quick, minimal bounce
    case stiff
    
    /// Wobbly spring - playful, lots of bounce
    case wobbly
    
    /// Custom spring
    case custom(response: Double, dampingFraction: Double, blendDuration: Double)
    
    public var animation: Animation {
        switch self {
        case .gentle:
            return .spring(response: 0.5, dampingFraction: 1.0)
        case .default:
            return .spring(response: 0.5, dampingFraction: 0.75)
        case .bouncy:
            return .spring(response: 0.5, dampingFraction: 0.5)
        case .stiff:
            return .spring(response: 0.3, dampingFraction: 0.8)
        case .wobbly:
            return .spring(response: 0.6, dampingFraction: 0.4)
        case .custom(let response, let dampingFraction, let blendDuration):
            return .spring(response: response, dampingFraction: dampingFraction, blendDuration: blendDuration)
        }
    }
}

// MARK: - Transition Tokens

public enum TransitionTokens {
    /// Opacity fade
    public static var fade: AnyTransition {
        .opacity
    }
    
    /// Scale with fade
    public static var scale: AnyTransition {
        .scale.combined(with: .opacity)
    }
    
    /// Slide from leading
    public static var slideLeading: AnyTransition {
        .move(edge: .leading).combined(with: .opacity)
    }
    
    /// Slide from trailing
    public static var slideTrailing: AnyTransition {
        .move(edge: .trailing).combined(with: .opacity)
    }
    
    /// Slide from top
    public static var slideTop: AnyTransition {
        .move(edge: .top).combined(with: .opacity)
    }
    
    /// Slide from bottom
    public static var slideBottom: AnyTransition {
        .move(edge: .bottom).combined(with: .opacity)
    }
    
    /// Scale up from center
    public static var scaleUp: AnyTransition {
        .asymmetric(
            insertion: .scale(scale: 0.8).combined(with: .opacity),
            removal: .scale(scale: 1.1).combined(with: .opacity)
        )
    }
    
    /// Modal presentation
    public static var modal: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .bottom).combined(with: .opacity),
            removal: .move(edge: .bottom).combined(with: .opacity)
        )
    }
    
    /// Toast notification
    public static var toast: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .top).combined(with: .opacity),
            removal: .move(edge: .top).combined(with: .opacity)
        )
    }
}

// MARK: - View Extensions

extension View {
    /// Apply animation token
    public func dsAnimation(_ token: AnimationToken) -> some View {
        self.animation(token.swiftUIAnimation, value: UUID())
    }
    
    /// Apply spring animation
    public func dsSpring(_ config: SpringConfig = .default) -> some View {
        self.animation(config.animation, value: UUID())
    }
    
    /// Apply animation token with value binding
    public func dsAnimation<V: Equatable>(_ token: AnimationToken, value: V) -> some View {
        self.animation(token.swiftUIAnimation, value: value)
    }
    
    /// Apply transition with animation token
    public func dsTransition(_ transition: AnyTransition, animation: AnimationToken) -> some View {
        self
            .transition(transition)
            .animation(animation.swiftUIAnimation, value: UUID())
    }
}

// MARK: - Animated Value Modifier

public struct DSAnimatedValue<Value: VectorArithmetic>: AnimatableModifier {
    public var animatableData: Value
    
    let content: (Value) -> AnyView
    
    public init(value: Value, @ViewBuilder content: @escaping (Value) -> some View) {
        self.animatableData = value
        self.content = { v in AnyView(content(v)) }
    }
    
    public func body(content: Content) -> some View {
        self.content(animatableData)
    }
}

// MARK: - Loading Animation

public struct DSLoadingAnimation: ViewModifier {
    @State private var isAnimating = false
    
    let duration: Double
    let repeatForever: Bool
    
    public init(duration: Double = 1.0, repeatForever: Bool = true) {
        self.duration = duration
        self.repeatForever = repeatForever
    }
    
    public func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .animation(
                Animation
                    .linear(duration: duration)
                    .repeatForever(autoreverses: false),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

extension View {
    /// Apply continuous rotation animation
    public func dsLoadingRotation(duration: Double = 1.0) -> some View {
        self.modifier(DSLoadingAnimation(duration: duration))
    }
}

// MARK: - Pulse Animation

public struct DSPulseAnimation: ViewModifier {
    @State private var isPulsing = false
    
    let minScale: CGFloat
    let maxScale: CGFloat
    let duration: Double
    
    public init(minScale: CGFloat = 0.95, maxScale: CGFloat = 1.05, duration: Double = 1.0) {
        self.minScale = minScale
        self.maxScale = maxScale
        self.duration = duration
    }
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? maxScale : minScale)
            .animation(
                Animation
                    .easeInOut(duration: duration)
                    .repeatForever(autoreverses: true),
                value: isPulsing
            )
            .onAppear {
                isPulsing = true
            }
    }
}

extension View {
    /// Apply pulse animation
    public func dsPulse(minScale: CGFloat = 0.95, maxScale: CGFloat = 1.05) -> some View {
        self.modifier(DSPulseAnimation(minScale: minScale, maxScale: maxScale))
    }
}

// MARK: - Shake Animation

extension View {
    /// Apply shake animation (for errors)
    public func dsShake(_ trigger: Bool) -> some View {
        self.modifier(ShakeEffect(animatableData: trigger ? 1 : 0))
    }
}

private struct ShakeEffect: GeometryEffect {
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = sin(animatableData * .pi * 4) * 10
        return ProjectionTransform(CGAffineTransform(translationX: translation, y: 0))
    }
}

// MARK: - Reduced Motion Support

extension View {
    /// Apply animation only if reduce motion is not enabled
    public func dsReducedMotionAnimation<V: Equatable>(_ token: AnimationToken, value: V) -> some View {
        self.modifier(ReducedMotionModifier(token: token, value: value))
    }
}

private struct ReducedMotionModifier<V: Equatable>: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    let token: AnimationToken
    let value: V
    
    func body(content: Content) -> some View {
        if reduceMotion {
            content
        } else {
            content.animation(token.swiftUIAnimation, value: value)
        }
    }
}
