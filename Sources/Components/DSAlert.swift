import SwiftUI

public struct DSAlert: View {
    @Binding public var isPresented: Bool
    public let title: String
    public let message: String?
    public let primaryButton: DSAlertButton
    public let secondaryButton: DSAlertButton?
    public let style: DSAlertStyle
    
    public init(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        primaryButton: DSAlertButton,
        secondaryButton: DSAlertButton? = nil,
        style: DSAlertStyle = .default
    ) {
        self._isPresented = isPresented
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        self.style = style
    }
    
    public var body: some View {
        ZStack {
            if isPresented {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        if style.dismissOnBackdropTap {
                            dismiss()
                        }
                    }
                    .transition(.opacity)
                
                VStack(spacing: 20) {
                    // Icon
                    if let icon = style.icon {
                        Image(systemName: icon)
                            .font(.system(size: 48, weight: .light))
                            .foregroundColor(style.iconColor)
                            .padding(.top, 20)
                    }
                    
                    // Title
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(style.titleColor)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    // Message
                    if let message = message {
                        Text(message)
                            .font(.body)
                            .foregroundColor(style.messageColor)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    
                    // Buttons
                    VStack(spacing: 12) {
                        DSButton(
                            title: primaryButton.title,
                            style: primaryButton.style,
                            action: {
                                primaryButton.action?()
                                dismiss()
                            }
                        )
                        
                        if let secondaryButton = secondaryButton {
                            DSButton(
                                title: secondaryButton.title,
                                style: secondaryButton.style,
                                action: {
                                    secondaryButton.action?()
                                    dismiss()
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: style.maxWidth)
                .background(style.backgroundColor(for: colorScheme))
                .cornerRadius(style.cornerRadius)
                .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                .transition(style.transition)
            }
        }
        .animation(style.animation, value: isPresented)
    }
    
    @Environment(\.colorScheme) private var colorScheme
    
    private func dismiss() {
        withAnimation(style.animation) {
            isPresented = false
        }
    }
}

public struct DSAlertButton {
    public let title: String
    public let style: DSButtonStyle
    public let action: (() -> Void)?
    
    public init(
        title: String,
        style: DSButtonStyle = .primary,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.style = style
        self.action = action
    }
}

public struct DSAlertStyle {
    public let maxWidth: CGFloat
    public let cornerRadius: CGFloat
    public let backgroundColor: (ColorScheme) -> Color
    public let titleColor: Color
    public let messageColor: Color
    public let iconColor: Color
    public let icon: String?
    public let dismissOnBackdropTap: Bool
    public let transition: AnyTransition
    public let animation: Animation
    
    public init(
        maxWidth: CGFloat,
        cornerRadius: CGFloat,
        backgroundColor: @escaping (ColorScheme) -> Color,
        titleColor: Color,
        messageColor: Color,
        iconColor: Color,
        icon: String?,
        dismissOnBackdropTap: Bool,
        transition: AnyTransition,
        animation: Animation
    ) {
        self.maxWidth = maxWidth
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.messageColor = messageColor
        self.iconColor = iconColor
        self.icon = icon
        self.dismissOnBackdropTap = dismissOnBackdropTap
        self.transition = transition
        self.animation = animation
    }
    
    public static let `default` = DSAlertStyle(
        maxWidth: 320,
        cornerRadius: 16,
        backgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray6) : .white
        },
        titleColor: .primary,
        messageColor: Color(.systemGray),
        iconColor: .blue,
        icon: nil,
        dismissOnBackdropTap: true,
        transition: .scale.combined(with: .opacity),
        animation: .spring(response: 0.5, dampingFraction: 0.7)
    )
    
    public static let success = DSAlertStyle(
        maxWidth: 320,
        cornerRadius: 16,
        backgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray6) : .white
        },
        titleColor: .primary,
        messageColor: Color(.systemGray),
        iconColor: .green,
        icon: "checkmark.circle.fill",
        dismissOnBackdropTap: true,
        transition: .scale.combined(with: .opacity),
        animation: .spring(response: 0.5, dampingFraction: 0.7)
    )
    
    public static let error = DSAlertStyle(
        maxWidth: 320,
        cornerRadius: 16,
        backgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray6) : .white
        },
        titleColor: .primary,
        messageColor: Color(.systemGray),
        iconColor: .red,
        icon: "exclamationmark.triangle.fill",
        dismissOnBackdropTap: true,
        transition: .scale.combined(with: .opacity),
        animation: .spring(response: 0.5, dampingFraction: 0.7)
    )
    
    public static let warning = DSAlertStyle(
        maxWidth: 320,
        cornerRadius: 16,
        backgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray6) : .white
        },
        titleColor: .primary,
        messageColor: Color(.systemGray),
        iconColor: .orange,
        icon: "exclamationmark.triangle.fill",
        dismissOnBackdropTap: true,
        transition: .scale.combined(with: .opacity),
        animation: .spring(response: 0.5, dampingFraction: 0.7)
    )
} 