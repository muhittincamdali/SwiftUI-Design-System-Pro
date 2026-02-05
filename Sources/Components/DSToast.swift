// DSToast.swift
// DesignSystemPro
//
// Production-grade toast notification system with
// variants, auto-dismiss, and queue management.

import SwiftUI
import Combine

// MARK: - Toast Variant

public enum DSToastVariant: String, CaseIterable, Sendable {
    case success
    case error
    case warning
    case info
    case neutral
    
    var icon: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .info: return "info.circle.fill"
        case .neutral: return ""
        }
    }
}

// MARK: - Toast Position

public enum DSToastPosition: Sendable {
    case top
    case bottom
}

// MARK: - Toast Data

public struct DSToastData: Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let message: String?
    public let variant: DSToastVariant
    public let duration: TimeInterval
    public let action: ToastAction?
    
    public init(
        id: String = UUID().uuidString,
        title: String,
        message: String? = nil,
        variant: DSToastVariant = .info,
        duration: TimeInterval = 4,
        action: ToastAction? = nil
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.variant = variant
        self.duration = duration
        self.action = action
    }
    
    public static func == (lhs: DSToastData, rhs: DSToastData) -> Bool {
        lhs.id == rhs.id
    }
}

public struct ToastAction: Sendable {
    public let label: String
    public let action: @Sendable () -> Void
    
    public init(label: String, action: @escaping @Sendable () -> Void) {
        self.label = label
        self.action = action
    }
}

// MARK: - Toast Manager

@MainActor
public final class DSToastManager: ObservableObject {
    public static let shared = DSToastManager()
    
    @Published public private(set) var toasts: [DSToastData] = []
    @Published public var position: DSToastPosition = .top
    
    private var dismissTimers: [String: Task<Void, Never>] = [:]
    
    private init() {}
    
    public func show(_ toast: DSToastData) {
        // Remove any existing toast with same ID
        toasts.removeAll { $0.id == toast.id }
        
        withAnimation(AnimationTokens.Page.modalEnter.swiftUIAnimation) {
            toasts.append(toast)
        }
        
        // Schedule auto-dismiss
        if toast.duration > 0 {
            let id = toast.id
            dismissTimers[id]?.cancel()
            dismissTimers[id] = Task {
                try? await Task.sleep(nanoseconds: UInt64(toast.duration * 1_000_000_000))
                dismiss(id: id)
            }
        }
    }
    
    public func dismiss(id: String) {
        dismissTimers[id]?.cancel()
        dismissTimers.removeValue(forKey: id)
        
        withAnimation(AnimationTokens.Page.modalExit.swiftUIAnimation) {
            toasts.removeAll { $0.id == id }
        }
    }
    
    public func dismissAll() {
        dismissTimers.values.forEach { $0.cancel() }
        dismissTimers.removeAll()
        
        withAnimation(AnimationTokens.Page.modalExit.swiftUIAnimation) {
            toasts.removeAll()
        }
    }
    
    // Convenience methods
    public func success(_ title: String, message: String? = nil) {
        show(DSToastData(title: title, message: message, variant: .success))
    }
    
    public func error(_ title: String, message: String? = nil) {
        show(DSToastData(title: title, message: message, variant: .error))
    }
    
    public func warning(_ title: String, message: String? = nil) {
        show(DSToastData(title: title, message: message, variant: .warning))
    }
    
    public func info(_ title: String, message: String? = nil) {
        show(DSToastData(title: title, message: message, variant: .info))
    }
}

// MARK: - Toast View

public struct DSToastView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let toast: DSToastData
    let onDismiss: () -> Void
    
    @State private var offset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    public var body: some View {
        HStack(spacing: SpacingScale.md.rawValue) {
            // Icon
            if !toast.variant.icon.isEmpty {
                Image(systemName: toast.variant.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(iconColor)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 2) {
                Text(toast.title)
                    .dsTypography(TypographyTokens.Body.mediumStrong)
                    .foregroundColor(ColorTokens.Foreground.primary.resolved(for: colorScheme))
                
                if let message = toast.message {
                    Text(message)
                        .dsTypography(TypographyTokens.Body.small)
                        .foregroundColor(ColorTokens.Foreground.secondary.resolved(for: colorScheme))
                }
            }
            
            Spacer()
            
            // Action Button
            if let action = toast.action {
                Button(action.label) {
                    action.action()
                    onDismiss()
                }
                .dsTypography(TypographyTokens.UI.button)
                .foregroundColor(ColorTokens.Accent.primary.resolved(for: colorScheme))
            }
            
            // Dismiss Button
            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 14, height: 14)
                    .foregroundColor(ColorTokens.Foreground.tertiary.resolved(for: colorScheme))
            }
            .buttonStyle(.plain)
        }
        .padding(InsetTokens.card)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: BorderTokens.Component.toast, style: .continuous))
        .dsShadow(ShadowTokens.toast)
        .overlay(
            RoundedRectangle(cornerRadius: BorderTokens.Component.toast, style: .continuous)
                .stroke(borderColor, lineWidth: BorderTokens.Width.hairline)
        )
        .offset(y: offset + dragOffset)
        .gesture(
            DragGesture()
                .updating($dragOffset) { value, state, _ in
                    state = value.translation.height
                }
                .onEnded { value in
                    if abs(value.translation.height) > 50 {
                        onDismiss()
                    }
                }
        )
    }
    
    private var iconColor: Color {
        switch toast.variant {
        case .success: return ColorTokens.Status.success.resolved(for: colorScheme)
        case .error: return ColorTokens.Status.error.resolved(for: colorScheme)
        case .warning: return ColorTokens.Status.warning.resolved(for: colorScheme)
        case .info: return ColorTokens.Status.info.resolved(for: colorScheme)
        case .neutral: return ColorTokens.Foreground.secondary.resolved(for: colorScheme)
        }
    }
    
    private var backgroundColor: Color {
        ColorTokens.Background.elevated.resolved(for: colorScheme)
    }
    
    private var borderColor: Color {
        ColorTokens.Border.primary.resolved(for: colorScheme)
    }
}

// MARK: - Toast Container

public struct DSToastContainer<Content: View>: View {
    @StateObject private var toastManager = DSToastManager.shared
    
    let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            content
            
            VStack {
                if toastManager.position == .top {
                    toastStack
                    Spacer()
                } else {
                    Spacer()
                    toastStack
                }
            }
            .padding(.horizontal, SpacingTokens.Layout.screenEdge)
            .padding(.vertical, SpacingTokens.Layout.pageTop)
        }
    }
    
    private var toastStack: some View {
        VStack(spacing: SpacingScale.sm.rawValue) {
            ForEach(toastManager.toasts) { toast in
                DSToastView(toast: toast) {
                    toastManager.dismiss(id: toast.id)
                }
                .transition(toastManager.position == .top ? .slideTop : .slideBottom)
            }
        }
    }
}

// MARK: - Toast Transitions

extension AnyTransition {
    static var slideTop: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .top).combined(with: .opacity),
            removal: .move(edge: .top).combined(with: .opacity)
        )
    }
    
    static var slideBottom: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .bottom).combined(with: .opacity),
            removal: .move(edge: .bottom).combined(with: .opacity)
        )
    }
}

// MARK: - View Extension

extension View {
    /// Wrap view with toast container
    public func dsToastContainer() -> some View {
        DSToastContainer {
            self
        }
    }
}

// MARK: - Snackbar (Alternative Toast Style)

public struct DSSnackbar: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let message: String
    let action: ToastAction?
    let onDismiss: () -> Void
    
    public init(
        message: String,
        action: ToastAction? = nil,
        onDismiss: @escaping () -> Void
    ) {
        self.message = message
        self.action = action
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        HStack(spacing: SpacingScale.lg.rawValue) {
            Text(message)
                .dsTypography(TypographyTokens.Body.small)
                .foregroundColor(.white)
            
            Spacer()
            
            if let action = action {
                Button(action.label) {
                    action.action()
                    onDismiss()
                }
                .dsTypography(TypographyTokens.UI.button)
                .foregroundColor(PrimitiveColors.Amber.amber400)
            }
        }
        .padding(.horizontal, SpacingScale.lg.rawValue)
        .padding(.vertical, SpacingScale.md.rawValue)
        .background(PrimitiveColors.Gray.gray800)
        .clipShape(RoundedRectangle(cornerRadius: BorderTokens.Radius.md, style: .continuous))
    }
}
