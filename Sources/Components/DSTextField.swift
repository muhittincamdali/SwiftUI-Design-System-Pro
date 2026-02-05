// DSTextField.swift
// DesignSystemPro
//
// Production-grade text input component with validation,
// states, and full accessibility support.

import SwiftUI
import Combine

// MARK: - Input State

public enum DSInputState: Sendable {
    case `default`
    case focused
    case valid
    case error(String)
    case disabled
}

// MARK: - Input Size

public enum DSInputSize: String, CaseIterable, Sendable {
    case sm  // 36pt height
    case md  // 44pt height - Default
    case lg  // 52pt height
    
    var height: CGFloat {
        switch self {
        case .sm: return 36
        case .md: return 44
        case .lg: return 52
        }
    }
    
    var typography: TypographyToken {
        switch self {
        case .sm: return TypographyTokens.Body.small
        case .md: return TypographyTokens.Body.medium
        case .lg: return TypographyTokens.Body.large
        }
    }
    
    var padding: EdgeInsets {
        switch self {
        case .sm: return EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        case .md: return EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        case .lg: return EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        }
    }
}

// MARK: - DSTextField

public struct DSTextField: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.isEnabled) private var isEnabled
    
    @Binding private var text: String
    @FocusState private var isFocused: Bool
    
    private let label: String
    private let placeholder: String
    private let helperText: String?
    private let size: DSInputSize
    private let leadingIcon: Image?
    private let trailingIcon: Image?
    private let state: DSInputState
    private let isSecure: Bool
    private let onSubmit: (() -> Void)?
    
    @State private var isSecureTextHidden = true
    
    public init(
        _ label: String = "",
        text: Binding<String>,
        placeholder: String = "",
        helperText: String? = nil,
        size: DSInputSize = .md,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        state: DSInputState = .default,
        isSecure: Bool = false,
        onSubmit: (() -> Void)? = nil
    ) {
        self.label = label
        self._text = text
        self.placeholder = placeholder
        self.helperText = helperText
        self.size = size
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.state = state
        self.isSecure = isSecure
        self.onSubmit = onSubmit
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: SpacingTokens.Form.labelGap) {
            // Label
            if !label.isEmpty {
                Text(label)
                    .dsTypography(TypographyTokens.UI.label)
                    .foregroundColor(labelColor)
            }
            
            // Input Container
            HStack(spacing: SpacingScale.sm.rawValue) {
                // Leading Icon
                if let icon = leadingIcon {
                    icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(iconColor)
                }
                
                // Text Input
                Group {
                    if isSecure && isSecureTextHidden {
                        SecureField(placeholder, text: $text)
                            .onSubmit { onSubmit?() }
                    } else {
                        TextField(placeholder, text: $text)
                            .onSubmit { onSubmit?() }
                    }
                }
                .dsTypography(size.typography)
                .foregroundColor(textColor)
                .focused($isFocused)
                .textFieldStyle(.plain)
                
                // Trailing Icon / Secure Toggle / Clear Button
                if isSecure {
                    Button(action: { isSecureTextHidden.toggle() }) {
                        Image(systemName: isSecureTextHidden ? "eye.slash" : "eye")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(iconColor)
                    }
                    .buttonStyle(.plain)
                } else if !text.isEmpty && isFocused {
                    Button(action: { text = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                            .foregroundColor(ColorTokens.Foreground.tertiary.resolved(for: colorScheme))
                    }
                    .buttonStyle(.plain)
                } else if let icon = trailingIcon {
                    icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(iconColor)
                }
            }
            .padding(size.padding)
            .frame(height: size.height)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: BorderTokens.Component.input, style: .continuous)
                    .strokeBorder(borderColor, lineWidth: borderWidth)
            )
            .clipShape(RoundedRectangle(cornerRadius: BorderTokens.Component.input, style: .continuous))
            .dsShadow(focusShadow)
            
            // Helper Text / Error Message
            if let helper = effectiveHelperText {
                Text(helper)
                    .dsTypography(TypographyTokens.UI.caption)
                    .foregroundColor(helperTextColor)
            }
        }
        .opacity(isEnabled ? 1 : 0.6)
        .animation(AnimationTokens.Micro.focus.swiftUIAnimation, value: isFocused)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label.isEmpty ? placeholder : label)
    }
    
    // MARK: - Computed Properties
    
    private var effectiveState: DSInputState {
        if !isEnabled { return .disabled }
        if isFocused && !hasError { return .focused }
        return state
    }
    
    private var hasError: Bool {
        if case .error = state { return true }
        return false
    }
    
    private var effectiveHelperText: String? {
        if case .error(let message) = state {
            return message
        }
        return helperText
    }
    
    private var labelColor: Color {
        if hasError {
            return ColorTokens.Status.error.resolved(for: colorScheme)
        }
        return ColorTokens.Foreground.secondary.resolved(for: colorScheme)
    }
    
    private var textColor: Color {
        ColorTokens.Foreground.primary.resolved(for: colorScheme)
    }
    
    private var iconColor: Color {
        if isFocused {
            return ColorTokens.Accent.primary.resolved(for: colorScheme)
        }
        return ColorTokens.Foreground.tertiary.resolved(for: colorScheme)
    }
    
    private var backgroundColor: Color {
        ColorTokens.Background.primary.resolved(for: colorScheme)
    }
    
    private var borderColor: Color {
        switch effectiveState {
        case .focused:
            return ColorTokens.Border.focus.resolved(for: colorScheme)
        case .valid:
            return ColorTokens.Status.success.resolved(for: colorScheme)
        case .error:
            return ColorTokens.Status.error.resolved(for: colorScheme)
        case .disabled:
            return ColorTokens.Border.primary.resolved(for: colorScheme).opacity(0.5)
        default:
            return ColorTokens.Border.primary.resolved(for: colorScheme)
        }
    }
    
    private var borderWidth: CGFloat {
        switch effectiveState {
        case .focused, .valid, .error:
            return BorderTokens.Width.medium
        default:
            return BorderTokens.Width.thin
        }
    }
    
    private var focusShadow: MultiLayerShadow {
        guard isFocused else { return ShadowTokens.none }
        if hasError {
            return ShadowTokens.inputError
        }
        return ShadowTokens.inputFocus
    }
    
    private var helperTextColor: Color {
        if hasError {
            return ColorTokens.Status.error.resolved(for: colorScheme)
        }
        return ColorTokens.Foreground.tertiary.resolved(for: colorScheme)
    }
}

// MARK: - TextArea

public struct DSTextArea: View {
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var isFocused: Bool
    
    @Binding private var text: String
    private let label: String
    private let placeholder: String
    private let helperText: String?
    private let minHeight: CGFloat
    private let maxHeight: CGFloat
    private let state: DSInputState
    
    public init(
        _ label: String = "",
        text: Binding<String>,
        placeholder: String = "",
        helperText: String? = nil,
        minHeight: CGFloat = 100,
        maxHeight: CGFloat = 300,
        state: DSInputState = .default
    ) {
        self.label = label
        self._text = text
        self.placeholder = placeholder
        self.helperText = helperText
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.state = state
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: SpacingTokens.Form.labelGap) {
            if !label.isEmpty {
                Text(label)
                    .dsTypography(TypographyTokens.UI.label)
                    .foregroundColor(ColorTokens.Foreground.secondary.resolved(for: colorScheme))
            }
            
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .dsTypography(TypographyTokens.Body.medium)
                        .foregroundColor(ColorTokens.Foreground.placeholder.resolved(for: colorScheme))
                        .padding(.horizontal, 4)
                        .padding(.vertical, 8)
                }
                
                TextEditor(text: $text)
                    .dsTypography(TypographyTokens.Body.medium)
                    .foregroundColor(ColorTokens.Foreground.primary.resolved(for: colorScheme))
                    .scrollContentBackground(.hidden)
                    .focused($isFocused)
            }
            .padding(InsetTokens.inputField)
            .frame(minHeight: minHeight, maxHeight: maxHeight)
            .background(ColorTokens.Background.primary.resolved(for: colorScheme))
            .overlay(
                RoundedRectangle(cornerRadius: BorderTokens.Component.input, style: .continuous)
                    .strokeBorder(
                        isFocused
                            ? ColorTokens.Border.focus.resolved(for: colorScheme)
                            : ColorTokens.Border.primary.resolved(for: colorScheme),
                        lineWidth: isFocused ? BorderTokens.Width.medium : BorderTokens.Width.thin
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: BorderTokens.Component.input, style: .continuous))
            
            if let helper = helperText {
                Text(helper)
                    .dsTypography(TypographyTokens.UI.caption)
                    .foregroundColor(ColorTokens.Foreground.tertiary.resolved(for: colorScheme))
            }
        }
    }
}

// MARK: - Search Field

public struct DSSearchField: View {
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var isFocused: Bool
    
    @Binding private var text: String
    private let placeholder: String
    private let onSubmit: (() -> Void)?
    
    public init(
        text: Binding<String>,
        placeholder: String = "Search...",
        onSubmit: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.onSubmit = onSubmit
    }
    
    public var body: some View {
        HStack(spacing: SpacingScale.sm.rawValue) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    isFocused
                        ? ColorTokens.Accent.primary.resolved(for: colorScheme)
                        : ColorTokens.Foreground.tertiary.resolved(for: colorScheme)
                )
            
            TextField(placeholder, text: $text)
                .dsTypography(TypographyTokens.Body.medium)
                .foregroundColor(ColorTokens.Foreground.primary.resolved(for: colorScheme))
                .focused($isFocused)
                .textFieldStyle(.plain)
                .onSubmit { onSubmit?() }
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(ColorTokens.Foreground.tertiary.resolved(for: colorScheme))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, SpacingScale.md.rawValue)
        .padding(.vertical, SpacingScale.sm.rawValue)
        .background(ColorTokens.Background.secondary.resolved(for: colorScheme))
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .strokeBorder(
                    isFocused
                        ? ColorTokens.Border.focus.resolved(for: colorScheme)
                        : Color.clear,
                    lineWidth: BorderTokens.Width.thin
                )
        )
        .animation(AnimationTokens.Micro.focus.swiftUIAnimation, value: isFocused)
    }
}

// MARK: - OTP Input

public struct DSOTPField: View {
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var focusedIndex: Int?
    
    @Binding private var code: String
    private let length: Int
    private let onComplete: ((String) -> Void)?
    
    public init(
        code: Binding<String>,
        length: Int = 6,
        onComplete: ((String) -> Void)? = nil
    ) {
        self._code = code
        self.length = length
        self.onComplete = onComplete
    }
    
    public var body: some View {
        HStack(spacing: SpacingScale.sm.rawValue) {
            ForEach(0..<length, id: \.self) { index in
                OTPDigitBox(
                    digit: digit(at: index),
                    isFocused: focusedIndex == index,
                    colorScheme: colorScheme
                )
                .onTapGesture {
                    focusedIndex = min(code.count, length - 1)
                }
            }
        }
        .background(
            TextField("", text: $code)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .focused($focusedIndex, equals: 0)
                .opacity(0)
                .onChange(of: code) { _, newValue in
                    let filtered = String(newValue.prefix(length).filter { $0.isNumber })
                    if filtered != newValue {
                        code = filtered
                    }
                    if filtered.count == length {
                        onComplete?(filtered)
                    }
                }
        )
        .onAppear {
            focusedIndex = 0
        }
    }
    
    private func digit(at index: Int) -> String {
        guard index < code.count else { return "" }
        let startIndex = code.index(code.startIndex, offsetBy: index)
        return String(code[startIndex])
    }
}

private struct OTPDigitBox: View {
    let digit: String
    let isFocused: Bool
    let colorScheme: ColorScheme
    
    var body: some View {
        Text(digit.isEmpty ? " " : digit)
            .dsTypography(TypographyTokens.Heading.h2)
            .foregroundColor(ColorTokens.Foreground.primary.resolved(for: colorScheme))
            .frame(width: 48, height: 56)
            .background(ColorTokens.Background.primary.resolved(for: colorScheme))
            .overlay(
                RoundedRectangle(cornerRadius: BorderTokens.Radius.md, style: .continuous)
                    .strokeBorder(
                        isFocused
                            ? ColorTokens.Border.focus.resolved(for: colorScheme)
                            : ColorTokens.Border.primary.resolved(for: colorScheme),
                        lineWidth: isFocused ? BorderTokens.Width.medium : BorderTokens.Width.thin
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: BorderTokens.Radius.md, style: .continuous))
            .dsShadow(isFocused ? ShadowTokens.inputFocus : ShadowTokens.none)
    }
}
