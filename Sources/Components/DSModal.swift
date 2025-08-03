import SwiftUI

public struct DSModal<Content: View>: View {
    @Binding public var isPresented: Bool
    public let title: String?
    public let content: Content
    public let style: DSModalStyle
    public let onDismiss: (() -> Void)?
    
    public init(
        isPresented: Binding<Bool>,
        title: String? = nil,
        style: DSModalStyle = .sheet,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self.title = title
        self.style = style
        self.onDismiss = onDismiss
        self.content = content()
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
                
                VStack(spacing: 0) {
                    if let title = title {
                        modalHeader(title: title)
                    }
                    
                    content
                        .padding(.horizontal, style.contentPadding)
                        .padding(.vertical, style.contentPadding)
                    
                    Spacer()
                }
                .frame(maxWidth: style.maxWidth)
                .frame(maxHeight: style.maxHeight)
                .background(style.backgroundColor(for: colorScheme))
                .cornerRadius(style.cornerRadius)
                .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                .transition(style.transition)
            }
        }
        .animation(style.animation, value: isPresented)
    }
    
    @Environment(\.colorScheme) private var colorScheme
    
    private func modalHeader(title: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(style.titleColor)
            
            Spacer()
            
            Button(action: dismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(style.closeButtonColor)
                    .frame(width: 32, height: 32)
                    .background(style.closeButtonBackgroundColor(for: colorScheme))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, style.contentPadding)
        .padding(.vertical, 16)
        .background(style.headerBackgroundColor(for: colorScheme))
    }
    
    private func dismiss() {
        withAnimation(style.animation) {
            isPresented = false
        }
        onDismiss?()
    }
}

public struct DSModalStyle {
    public let maxWidth: CGFloat
    public let maxHeight: CGFloat
    public let cornerRadius: CGFloat
    public let contentPadding: CGFloat
    public let backgroundColor: (ColorScheme) -> Color
    public let headerBackgroundColor: (ColorScheme) -> Color
    public let titleColor: Color
    public let closeButtonColor: Color
    public let closeButtonBackgroundColor: (ColorScheme) -> Color
    public let dismissOnBackdropTap: Bool
    public let transition: AnyTransition
    public let animation: Animation
    
    public init(
        maxWidth: CGFloat,
        maxHeight: CGFloat,
        cornerRadius: CGFloat,
        contentPadding: CGFloat,
        backgroundColor: @escaping (ColorScheme) -> Color,
        headerBackgroundColor: @escaping (ColorScheme) -> Color,
        titleColor: Color,
        closeButtonColor: Color,
        closeButtonBackgroundColor: @escaping (ColorScheme) -> Color,
        dismissOnBackdropTap: Bool,
        transition: AnyTransition,
        animation: Animation
    ) {
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.cornerRadius = cornerRadius
        self.contentPadding = contentPadding
        self.backgroundColor = backgroundColor
        self.headerBackgroundColor = headerBackgroundColor
        self.titleColor = titleColor
        self.closeButtonColor = closeButtonColor
        self.closeButtonBackgroundColor = closeButtonBackgroundColor
        self.dismissOnBackdropTap = dismissOnBackdropTap
        self.transition = transition
        self.animation = animation
    }
    
    public static let sheet = DSModalStyle(
        maxWidth: .infinity,
        maxHeight: UIScreen.main.bounds.height * 0.8,
        cornerRadius: 20,
        contentPadding: 20,
        backgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray6) : .white
        },
        headerBackgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray6) : .white
        },
        titleColor: .primary,
        closeButtonColor: Color(.systemGray),
        closeButtonBackgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6)
        },
        dismissOnBackdropTap: true,
        transition: .move(edge: .bottom).combined(with: .opacity),
        animation: .spring(response: 0.6, dampingFraction: 0.8)
    )
    
    public static let center = DSModalStyle(
        maxWidth: 400,
        maxHeight: 600,
        cornerRadius: 16,
        contentPadding: 24,
        backgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray6) : .white
        },
        headerBackgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray6) : .white
        },
        titleColor: .primary,
        closeButtonColor: Color(.systemGray),
        closeButtonBackgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6)
        },
        dismissOnBackdropTap: true,
        transition: .scale.combined(with: .opacity),
        animation: .spring(response: 0.5, dampingFraction: 0.7)
    )
    
    public static let fullScreen = DSModalStyle(
        maxWidth: .infinity,
        maxHeight: .infinity,
        cornerRadius: 0,
        contentPadding: 20,
        backgroundColor: { colorScheme in
            colorScheme == .dark ? .black : .white
        },
        headerBackgroundColor: { colorScheme in
            colorScheme == .dark ? .black : .white
        },
        titleColor: .primary,
        closeButtonColor: Color(.systemGray),
        closeButtonBackgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6)
        },
        dismissOnBackdropTap: false,
        transition: .opacity,
        animation: .easeInOut(duration: 0.3)
    )
} 