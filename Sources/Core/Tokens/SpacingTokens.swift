// SpacingTokens.swift
// DesignSystemPro
//
// Production-grade spacing system based on 8pt grid
// with semantic naming and responsive support.

import SwiftUI

// MARK: - Spacing Scale

/// Spacing scale based on 8pt grid system
/// This provides consistent, harmonious spacing across the UI
public enum SpacingScale: CGFloat, CaseIterable, Sendable {
    /// 0pt - No spacing
    case none = 0
    
    /// 2pt - Micro spacing (icons, tight groups)
    case xxxs = 2
    
    /// 4pt - Extra extra small (tight padding)
    case xxs = 4
    
    /// 6pt - Extra small variant
    case xs = 6
    
    /// 8pt - Base unit (1x grid)
    case sm = 8
    
    /// 12pt - Small-medium
    case md = 12
    
    /// 16pt - Medium (2x grid) - Most common
    case lg = 16
    
    /// 20pt - Medium-large
    case xl = 20
    
    /// 24pt - Large (3x grid)
    case xxl = 24
    
    /// 32pt - Extra large (4x grid)
    case xxxl = 32
    
    /// 40pt - 2XL spacing
    case huge = 40
    
    /// 48pt - 3XL spacing (6x grid)
    case massive = 48
    
    /// 64pt - 4XL spacing (8x grid)
    case giant = 64
    
    /// 80pt - 5XL spacing
    case colossal = 80
    
    /// 96pt - 6XL spacing (12x grid)
    case astronomical = 96
}

// MARK: - Semantic Spacing Tokens

public enum SpacingTokens {
    
    // MARK: - Component Internal Spacing
    public enum Component {
        /// Spacing between icon and text in buttons
        public static let iconGap: CGFloat = SpacingScale.xxs.rawValue
        
        /// Small internal padding for compact components
        public static let paddingXS: CGFloat = SpacingScale.xxs.rawValue
        
        /// Standard internal padding for components
        public static let paddingSM: CGFloat = SpacingScale.sm.rawValue
        
        /// Medium internal padding
        public static let paddingMD: CGFloat = SpacingScale.md.rawValue
        
        /// Large internal padding
        public static let paddingLG: CGFloat = SpacingScale.lg.rawValue
        
        /// Extra large padding for spacious components
        public static let paddingXL: CGFloat = SpacingScale.xl.rawValue
    }
    
    // MARK: - Content Spacing
    public enum Content {
        /// Tight spacing between related items
        public static let tight: CGFloat = SpacingScale.xxs.rawValue
        
        /// Default spacing between items in a group
        public static let `default`: CGFloat = SpacingScale.sm.rawValue
        
        /// Comfortable spacing for readability
        public static let comfortable: CGFloat = SpacingScale.lg.rawValue
        
        /// Relaxed spacing for visual breathing room
        public static let relaxed: CGFloat = SpacingScale.xl.rawValue
        
        /// Spacious layout spacing
        public static let spacious: CGFloat = SpacingScale.xxl.rawValue
    }
    
    // MARK: - Layout Spacing
    public enum Layout {
        /// Screen edge padding (iOS standard: 16pt)
        public static let screenEdge: CGFloat = SpacingScale.lg.rawValue
        
        /// Card/section padding
        public static let cardPadding: CGFloat = SpacingScale.lg.rawValue
        
        /// Spacing between sections
        public static let sectionGap: CGFloat = SpacingScale.xxl.rawValue
        
        /// Large section gap
        public static let sectionGapLarge: CGFloat = SpacingScale.xxxl.rawValue
        
        /// Page top padding
        public static let pageTop: CGFloat = SpacingScale.xl.rawValue
        
        /// Page bottom padding (with safe area consideration)
        public static let pageBottom: CGFloat = SpacingScale.xxxl.rawValue
        
        /// List item vertical padding
        public static let listItemVertical: CGFloat = SpacingScale.md.rawValue
        
        /// List item horizontal padding
        public static let listItemHorizontal: CGFloat = SpacingScale.lg.rawValue
        
        /// Grid gap for grid layouts
        public static let gridGap: CGFloat = SpacingScale.lg.rawValue
        
        /// Stack gap for VStack/HStack
        public static let stackGap: CGFloat = SpacingScale.sm.rawValue
    }
    
    // MARK: - Form Spacing
    public enum Form {
        /// Space between form label and input
        public static let labelGap: CGFloat = SpacingScale.xxs.rawValue
        
        /// Space between form fields
        public static let fieldGap: CGFloat = SpacingScale.lg.rawValue
        
        /// Space between form sections
        public static let sectionGap: CGFloat = SpacingScale.xxl.rawValue
        
        /// Input field internal padding
        public static let inputPadding: CGFloat = SpacingScale.md.rawValue
        
        /// Helper text margin top
        public static let helperTextGap: CGFloat = SpacingScale.xxs.rawValue
    }
    
    // MARK: - Navigation Spacing
    public enum Navigation {
        /// Tab bar item spacing
        public static let tabBarItemGap: CGFloat = SpacingScale.none.rawValue
        
        /// Navigation bar content padding
        public static let barPadding: CGFloat = SpacingScale.lg.rawValue
        
        /// Menu item padding
        public static let menuItemPadding: CGFloat = SpacingScale.md.rawValue
        
        /// Breadcrumb separator padding
        public static let breadcrumbGap: CGFloat = SpacingScale.sm.rawValue
    }
    
    // MARK: - Modal Spacing
    public enum Modal {
        /// Modal internal padding
        public static let padding: CGFloat = SpacingScale.xl.rawValue
        
        /// Space between modal header and content
        public static let headerGap: CGFloat = SpacingScale.lg.rawValue
        
        /// Space between modal content and footer
        public static let footerGap: CGFloat = SpacingScale.xl.rawValue
        
        /// Button group spacing in modal footer
        public static let buttonGap: CGFloat = SpacingScale.md.rawValue
    }
}

// MARK: - Edge Insets Tokens

public enum InsetTokens {
    /// Zero insets
    public static let zero = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    /// Extra small uniform inset (4pt)
    public static let xs = EdgeInsets(
        top: SpacingScale.xxs.rawValue,
        leading: SpacingScale.xxs.rawValue,
        bottom: SpacingScale.xxs.rawValue,
        trailing: SpacingScale.xxs.rawValue
    )
    
    /// Small uniform inset (8pt)
    public static let sm = EdgeInsets(
        top: SpacingScale.sm.rawValue,
        leading: SpacingScale.sm.rawValue,
        bottom: SpacingScale.sm.rawValue,
        trailing: SpacingScale.sm.rawValue
    )
    
    /// Medium uniform inset (12pt)
    public static let md = EdgeInsets(
        top: SpacingScale.md.rawValue,
        leading: SpacingScale.md.rawValue,
        bottom: SpacingScale.md.rawValue,
        trailing: SpacingScale.md.rawValue
    )
    
    /// Large uniform inset (16pt)
    public static let lg = EdgeInsets(
        top: SpacingScale.lg.rawValue,
        leading: SpacingScale.lg.rawValue,
        bottom: SpacingScale.lg.rawValue,
        trailing: SpacingScale.lg.rawValue
    )
    
    /// Extra large uniform inset (24pt)
    public static let xl = EdgeInsets(
        top: SpacingScale.xxl.rawValue,
        leading: SpacingScale.xxl.rawValue,
        bottom: SpacingScale.xxl.rawValue,
        trailing: SpacingScale.xxl.rawValue
    )
    
    /// Horizontal only inset (16pt sides)
    public static let horizontalMD = EdgeInsets(
        top: 0,
        leading: SpacingScale.lg.rawValue,
        bottom: 0,
        trailing: SpacingScale.lg.rawValue
    )
    
    /// Vertical only inset (16pt top/bottom)
    public static let verticalMD = EdgeInsets(
        top: SpacingScale.lg.rawValue,
        leading: 0,
        bottom: SpacingScale.lg.rawValue,
        trailing: 0
    )
    
    /// Button inset (12pt vertical, 16pt horizontal)
    public static let button = EdgeInsets(
        top: SpacingScale.md.rawValue,
        leading: SpacingScale.lg.rawValue,
        bottom: SpacingScale.md.rawValue,
        trailing: SpacingScale.lg.rawValue
    )
    
    /// Card inset (16pt all around)
    public static let card = EdgeInsets(
        top: SpacingScale.lg.rawValue,
        leading: SpacingScale.lg.rawValue,
        bottom: SpacingScale.lg.rawValue,
        trailing: SpacingScale.lg.rawValue
    )
    
    /// List item inset
    public static let listItem = EdgeInsets(
        top: SpacingScale.md.rawValue,
        leading: SpacingScale.lg.rawValue,
        bottom: SpacingScale.md.rawValue,
        trailing: SpacingScale.lg.rawValue
    )
    
    /// Input field inset
    public static let inputField = EdgeInsets(
        top: SpacingScale.md.rawValue,
        leading: SpacingScale.md.rawValue,
        bottom: SpacingScale.md.rawValue,
        trailing: SpacingScale.md.rawValue
    )
}

// MARK: - Spacing View Modifier

public struct DSSpacingModifier: ViewModifier {
    let padding: EdgeInsets
    
    public func body(content: Content) -> some View {
        content.padding(padding)
    }
}

// MARK: - View Extensions

extension View {
    /// Apply spacing token as padding
    public func dsPadding(_ scale: SpacingScale) -> some View {
        self.padding(scale.rawValue)
    }
    
    /// Apply spacing token as horizontal padding
    public func dsPaddingH(_ scale: SpacingScale) -> some View {
        self.padding(.horizontal, scale.rawValue)
    }
    
    /// Apply spacing token as vertical padding
    public func dsPaddingV(_ scale: SpacingScale) -> some View {
        self.padding(.vertical, scale.rawValue)
    }
    
    /// Apply inset token as padding
    public func dsPadding(_ insets: EdgeInsets) -> some View {
        self.padding(insets)
    }
    
    /// Apply screen edge padding
    public func dsScreenEdgePadding() -> some View {
        self.padding(.horizontal, SpacingTokens.Layout.screenEdge)
    }
    
    /// Apply card padding
    public func dsCardPadding() -> some View {
        self.padding(InsetTokens.card)
    }
}

// MARK: - Spacing Stack Extensions

extension VStack {
    /// Create a VStack with design system spacing
    public static func ds(
        spacing: SpacingScale = .sm,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> some View
    ) -> some View {
        VStack(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

extension HStack {
    /// Create an HStack with design system spacing
    public static func ds(
        spacing: SpacingScale = .sm,
        alignment: VerticalAlignment = .center,
        @ViewBuilder content: () -> some View
    ) -> some View {
        HStack(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

// MARK: - Spacer with Token Size

/// A spacer with a fixed size based on spacing token
public struct DSSpacer: View {
    let size: SpacingScale
    let axis: Axis
    
    public init(_ size: SpacingScale = .md, axis: Axis = .vertical) {
        self.size = size
        self.axis = axis
    }
    
    public var body: some View {
        switch axis {
        case .vertical:
            Spacer().frame(height: size.rawValue)
        case .horizontal:
            Spacer().frame(width: size.rawValue)
        }
    }
}

// MARK: - Divider with Spacing

/// A divider with consistent spacing tokens
public struct DSDivider: View {
    let spacing: SpacingScale
    let color: Color
    let thickness: CGFloat
    
    public init(
        spacing: SpacingScale = .lg,
        color: Color = ColorTokens.Border.primary.light,
        thickness: CGFloat = 1
    ) {
        self.spacing = spacing
        self.color = color
        self.thickness = thickness
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: spacing.rawValue)
            Rectangle()
                .fill(color)
                .frame(height: thickness)
            Spacer().frame(height: spacing.rawValue)
        }
    }
}

// MARK: - Grid Layout Helpers

public enum GridTokens {
    /// Number of columns for different screen sizes
    public static func columns(for width: CGFloat) -> Int {
        switch width {
        case ..<375: return 2
        case 375..<768: return 2
        case 768..<1024: return 3
        case 1024..<1440: return 4
        default: return 6
        }
    }
    
    /// Grid item minimum width
    public static let itemMinWidth: CGFloat = 150
    
    /// Create adaptive grid items
    public static func adaptiveItems(minWidth: CGFloat = itemMinWidth) -> [GridItem] {
        [GridItem(.adaptive(minimum: minWidth), spacing: SpacingTokens.Layout.gridGap)]
    }
    
    /// Create fixed column grid items
    public static func fixedItems(count: Int) -> [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: SpacingTokens.Layout.gridGap), count: count)
    }
}

// MARK: - Responsive Spacing

/// Responsive spacing that adapts to screen size
public struct ResponsiveSpacing {
    public let compact: CGFloat
    public let regular: CGFloat
    public let expanded: CGFloat
    
    public init(
        compact: SpacingScale,
        regular: SpacingScale,
        expanded: SpacingScale
    ) {
        self.compact = compact.rawValue
        self.regular = regular.rawValue
        self.expanded = expanded.rawValue
    }
    
    public func value(for sizeClass: UserInterfaceSizeClass?) -> CGFloat {
        switch sizeClass {
        case .compact:
            return compact
        case .regular:
            return regular
        default:
            return regular
        }
    }
}

// MARK: - Safe Area Spacing

public enum SafeAreaTokens {
    /// Minimum bottom padding for buttons (considering home indicator)
    public static let bottomAction: CGFloat = SpacingScale.xxxl.rawValue
    
    /// Keyboard avoidance extra padding
    public static let keyboardBuffer: CGFloat = SpacingScale.lg.rawValue
}
