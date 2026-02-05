// DSToggle.swift
// DesignSystemPro
//
// Production-grade toggle, checkbox, and radio components
// with full accessibility support.

import SwiftUI

// MARK: - Toggle Size

public enum DSToggleSize: String, CaseIterable, Sendable {
    case sm  // Small
    case md  // Medium (default)
    case lg  // Large
    
    var trackWidth: CGFloat {
        switch self {
        case .sm: return 36
        case .md: return 44
        case .lg: return 52
        }
    }
    
    var trackHeight: CGFloat {
        switch self {
        case .sm: return 20
        case .md: return 24
        case .lg: return 28
        }
    }
    
    var thumbSize: CGFloat {
        switch self {
        case .sm: return 16
        case .md: return 20
        case .lg: return 24
        }
    }
    
    var thumbPadding: CGFloat {
        return 2
    }
}

// MARK: - DSToggle

public struct DSToggle: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.isEnabled) private var isEnabled
    
    @Binding private var isOn: Bool
    private let label: String?
    private let size: DSToggleSize
    private let onColor: Color?
    
    public init(
        isOn: Binding<Bool>,
        label: String? = nil,
        size: DSToggleSize = .md,
        onColor: Color? = nil
    ) {
        self._isOn = isOn
        self.label = label
        self.size = size
        self.onColor = onColor
    }
    
    public var body: some View {
        HStack(spacing: SpacingScale.md.rawValue) {
            toggleControl
            
            if let label = label {
                Text(label)
                    .dsTypography(TypographyTokens.Body.medium)
                    .foregroundColor(
                        isEnabled
                            ? ColorTokens.Foreground.primary.resolved(for: colorScheme)
                            : ColorTokens.Foreground.disabled.resolved(for: colorScheme)
                    )
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label ?? "Toggle")
        .accessibilityValue(isOn ? "On" : "Off")
        .accessibilityAddTraits(.isButton)
    }
    
    private var toggleControl: some View {
        ZStack(alignment: isOn ? .trailing : .leading) {
            // Track
            Capsule()
                .fill(trackColor)
                .frame(width: size.trackWidth, height: size.trackHeight)
            
            // Thumb
            Circle()
                .fill(thumbColor)
                .frame(width: size.thumbSize, height: size.thumbSize)
                .padding(size.thumbPadding)
                .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
        }
        .animation(AnimationTokens.Micro.toggle.swiftUIAnimation, value: isOn)
        .onTapGesture {
            guard isEnabled else { return }
            isOn.toggle()
        }
    }
    
    private var trackColor: Color {
        if !isEnabled {
            return ColorTokens.Interactive.disabled.resolved(for: colorScheme)
        }
        if isOn {
            return onColor ?? ColorTokens.Accent.primary.resolved(for: colorScheme)
        }
        return ColorTokens.Background.tertiary.resolved(for: colorScheme)
    }
    
    private var thumbColor: Color {
        .white
    }
}

// MARK: - DSCheckbox

public struct DSCheckbox: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.isEnabled) private var isEnabled
    
    @Binding private var isChecked: Bool
    private let label: String?
    private let isIndeterminate: Bool
    
    public init(
        isChecked: Binding<Bool>,
        label: String? = nil,
        isIndeterminate: Bool = false
    ) {
        self._isChecked = isChecked
        self.label = label
        self.isIndeterminate = isIndeterminate
    }
    
    public var body: some View {
        HStack(spacing: SpacingScale.sm.rawValue) {
            checkboxControl
            
            if let label = label {
                Text(label)
                    .dsTypography(TypographyTokens.Body.medium)
                    .foregroundColor(
                        isEnabled
                            ? ColorTokens.Foreground.primary.resolved(for: colorScheme)
                            : ColorTokens.Foreground.disabled.resolved(for: colorScheme)
                    )
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            guard isEnabled else { return }
            isChecked.toggle()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label ?? "Checkbox")
        .accessibilityValue(isChecked ? "Checked" : "Unchecked")
        .accessibilityAddTraits(.isButton)
    }
    
    private var checkboxControl: some View {
        ZStack {
            RoundedRectangle(cornerRadius: BorderTokens.Component.checkbox, style: .continuous)
                .fill(backgroundColor)
                .frame(width: 20, height: 20)
            
            RoundedRectangle(cornerRadius: BorderTokens.Component.checkbox, style: .continuous)
                .strokeBorder(borderColor, lineWidth: BorderTokens.Width.medium)
                .frame(width: 20, height: 20)
            
            if isChecked || isIndeterminate {
                Image(systemName: isIndeterminate ? "minus" : "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .animation(AnimationTokens.Micro.checkbox.swiftUIAnimation, value: isChecked)
    }
    
    private var backgroundColor: Color {
        if isChecked || isIndeterminate {
            return isEnabled
                ? ColorTokens.Accent.primary.resolved(for: colorScheme)
                : ColorTokens.Accent.primary.resolved(for: colorScheme).opacity(0.5)
        }
        return .clear
    }
    
    private var borderColor: Color {
        if isChecked || isIndeterminate {
            return isEnabled
                ? ColorTokens.Accent.primary.resolved(for: colorScheme)
                : ColorTokens.Accent.primary.resolved(for: colorScheme).opacity(0.5)
        }
        return isEnabled
            ? ColorTokens.Border.secondary.resolved(for: colorScheme)
            : ColorTokens.Border.primary.resolved(for: colorScheme).opacity(0.5)
    }
}

// MARK: - DSRadio

public struct DSRadio: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.isEnabled) private var isEnabled
    
    @Binding private var isSelected: Bool
    private let label: String?
    
    public init(
        isSelected: Binding<Bool>,
        label: String? = nil
    ) {
        self._isSelected = isSelected
        self.label = label
    }
    
    public var body: some View {
        HStack(spacing: SpacingScale.sm.rawValue) {
            radioControl
            
            if let label = label {
                Text(label)
                    .dsTypography(TypographyTokens.Body.medium)
                    .foregroundColor(
                        isEnabled
                            ? ColorTokens.Foreground.primary.resolved(for: colorScheme)
                            : ColorTokens.Foreground.disabled.resolved(for: colorScheme)
                    )
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            guard isEnabled else { return }
            isSelected = true
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label ?? "Radio button")
        .accessibilityValue(isSelected ? "Selected" : "Not selected")
        .accessibilityAddTraits(.isButton)
    }
    
    private var radioControl: some View {
        ZStack {
            Circle()
                .strokeBorder(borderColor, lineWidth: BorderTokens.Width.medium)
                .frame(width: 20, height: 20)
            
            if isSelected {
                Circle()
                    .fill(fillColor)
                    .frame(width: 10, height: 10)
            }
        }
        .animation(AnimationTokens.Micro.checkbox.swiftUIAnimation, value: isSelected)
    }
    
    private var borderColor: Color {
        if isSelected {
            return isEnabled
                ? ColorTokens.Accent.primary.resolved(for: colorScheme)
                : ColorTokens.Accent.primary.resolved(for: colorScheme).opacity(0.5)
        }
        return isEnabled
            ? ColorTokens.Border.secondary.resolved(for: colorScheme)
            : ColorTokens.Border.primary.resolved(for: colorScheme).opacity(0.5)
    }
    
    private var fillColor: Color {
        isEnabled
            ? ColorTokens.Accent.primary.resolved(for: colorScheme)
            : ColorTokens.Accent.primary.resolved(for: colorScheme).opacity(0.5)
    }
}

// MARK: - DSRadioGroup

public struct DSRadioGroup<T: Hashable & CustomStringConvertible>: View {
    @Binding private var selection: T
    private let options: [T]
    private let spacing: CGFloat
    private let axis: Axis
    
    public init(
        selection: Binding<T>,
        options: [T],
        spacing: CGFloat = SpacingScale.md.rawValue,
        axis: Axis = .vertical
    ) {
        self._selection = selection
        self.options = options
        self.spacing = spacing
        self.axis = axis
    }
    
    public var body: some View {
        let layout = axis == .vertical
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: spacing))
            : AnyLayout(HStackLayout(spacing: spacing))
        
        layout {
            ForEach(options, id: \.self) { option in
                DSRadio(
                    isSelected: Binding(
                        get: { selection == option },
                        set: { if $0 { selection = option } }
                    ),
                    label: option.description
                )
            }
        }
    }
}

// MARK: - DSCheckboxGroup

public struct DSCheckboxGroup: View {
    @Binding private var selections: Set<String>
    private let options: [String]
    private let spacing: CGFloat
    
    public init(
        selections: Binding<Set<String>>,
        options: [String],
        spacing: CGFloat = SpacingScale.md.rawValue
    ) {
        self._selections = selections
        self.options = options
        self.spacing = spacing
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(options, id: \.self) { option in
                DSCheckbox(
                    isChecked: Binding(
                        get: { selections.contains(option) },
                        set: { isChecked in
                            if isChecked {
                                selections.insert(option)
                            } else {
                                selections.remove(option)
                            }
                        }
                    ),
                    label: option
                )
            }
        }
    }
}

// MARK: - DSSwitch (iOS Native Style)

public struct DSSwitch: View {
    @Binding private var isOn: Bool
    private let label: String?
    private let tint: Color?
    
    public init(
        isOn: Binding<Bool>,
        label: String? = nil,
        tint: Color? = nil
    ) {
        self._isOn = isOn
        self.label = label
        self.tint = tint
    }
    
    public var body: some View {
        if let label = label {
            Toggle(label, isOn: $isOn)
                .tint(tint ?? ColorTokens.Accent.primary.light)
                .toggleStyle(.switch)
        } else {
            Toggle("", isOn: $isOn)
                .tint(tint ?? ColorTokens.Accent.primary.light)
                .toggleStyle(.switch)
                .labelsHidden()
        }
    }
}
