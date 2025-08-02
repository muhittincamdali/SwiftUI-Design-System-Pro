import SwiftUI

/**
 * Button Examples
 * 
 * Comprehensive examples showing how to use DSButton component
 * with different styles, sizes, and configurations.
 */
struct ButtonExamples: View {
    @State private var isEnabled = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Basic Buttons
                basicButtonsSection
                
                // Button Sizes
                buttonSizesSection
                
                // Button Styles
                buttonStylesSection
                
                // Interactive Buttons
                interactiveButtonsSection
                
                // Accessibility Buttons
                accessibilityButtonsSection
            }
            .padding()
        }
        .navigationTitle("Button Examples")
    }
    
    // MARK: - Basic Buttons
    private var basicButtonsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Basic Buttons")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSButton(
                    title: "Primary Button",
                    style: .primary,
                    action: { print("Primary button tapped") }
                )
                
                DSButton(
                    title: "Secondary Button",
                    style: .secondary,
                    action: { print("Secondary button tapped") }
                )
                
                DSButton(
                    title: "Tertiary Button",
                    style: .tertiary,
                    action: { print("Tertiary button tapped") }
                )
            }
        }
    }
    
    // MARK: - Button Sizes
    private var buttonSizesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Button Sizes")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSButton(
                    title: "Large Button",
                    style: .primary,
                    size: .large,
                    action: { print("Large button tapped") }
                )
                
                DSButton(
                    title: "Medium Button",
                    style: .primary,
                    size: .medium,
                    action: { print("Medium button tapped") }
                )
                
                DSButton(
                    title: "Small Button",
                    style: .primary,
                    size: .small,
                    action: { print("Small button tapped") }
                )
            }
        }
    }
    
    // MARK: - Button Styles
    private var buttonStylesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Button Styles")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSButton(
                    title: "Primary Style",
                    style: .primary,
                    action: { print("Primary style tapped") }
                )
                
                DSButton(
                    title: "Secondary Style",
                    style: .secondary,
                    action: { print("Secondary style tapped") }
                )
                
                DSButton(
                    title: "Tertiary Style",
                    style: .tertiary,
                    action: { print("Tertiary style tapped") }
                )
                
                DSButton(
                    title: "Destructive Style",
                    style: .destructive,
                    action: { print("Destructive style tapped") }
                )
            }
        }
    }
    
    // MARK: - Interactive Buttons
    private var interactiveButtonsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Interactive Buttons")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSButton(
                    title: "Enabled Button",
                    style: .primary,
                    action: { print("Enabled button tapped") }
                )
                .disabled(!isEnabled)
                
                DSButton(
                    title: "Disabled Button",
                    style: .primary,
                    action: { print("This won't be called") }
                )
                .disabled(true)
                
                Toggle("Enable Buttons", isOn: $isEnabled)
                    .padding(.top)
            }
        }
    }
    
    // MARK: - Accessibility Buttons
    private var accessibilityButtonsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Accessibility Buttons")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSButton(
                    title: "Submit Form",
                    style: .primary,
                    action: { print("Form submitted") }
                )
                .accessibilityLabel("Submit form button")
                .accessibilityHint("Double tap to submit the form")
                
                DSButton(
                    title: "Delete Item",
                    style: .destructive,
                    action: { print("Item deleted") }
                )
                .accessibilityLabel("Delete item button")
                .accessibilityHint("Double tap to delete this item")
                
                DSButton(
                    title: "Save Changes",
                    style: .secondary,
                    action: { print("Changes saved") }
                )
                .accessibilityLabel("Save changes button")
                .accessibilityHint("Double tap to save your changes")
            }
        }
    }
}

// MARK: - Previews
struct ButtonExamples_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ButtonExamples()
        }
    }
} 