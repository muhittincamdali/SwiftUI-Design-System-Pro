import SwiftUI

struct AlertExamples: View {
    @State private var showDefaultAlert = false
    @State private var showSuccessAlert = false
    @State private var showErrorAlert = false
    @State private var showWarningAlert = false
    @State private var showConfirmationAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Alert Types
                alertTypesSection
                
                // Alert with Actions
                alertWithActionsSection
                
                // Alert Styles
                alertStylesSection
            }
            .padding()
        }
        .navigationTitle("Alert Examples")
        .overlay(
            // Default Alert
            DSAlert(
                isPresented: $showDefaultAlert,
                title: "Default Alert",
                message: "This is a default alert with a simple message.",
                primaryButton: DSAlertButton(title: "OK")
            )
        )
        .overlay(
            // Success Alert
            DSAlert(
                isPresented: $showSuccessAlert,
                title: "Success!",
                message: "Your action was completed successfully.",
                primaryButton: DSAlertButton(title: "Great!"),
                style: .success
            )
        )
        .overlay(
            // Error Alert
            DSAlert(
                isPresented: $showErrorAlert,
                title: "Error",
                message: "Something went wrong. Please try again.",
                primaryButton: DSAlertButton(title: "Try Again"),
                secondaryButton: DSAlertButton(title: "Cancel", style: .secondary),
                style: .error
            )
        )
        .overlay(
            // Warning Alert
            DSAlert(
                isPresented: $showWarningAlert,
                title: "Warning",
                message: "This action cannot be undone. Are you sure?",
                primaryButton: DSAlertButton(title: "Continue", style: .destructive),
                secondaryButton: DSAlertButton(title: "Cancel", style: .secondary),
                style: .warning
            )
        )
        .overlay(
            // Confirmation Alert
            DSAlert(
                isPresented: $showConfirmationAlert,
                title: "Confirm Action",
                message: "Are you sure you want to delete this item?",
                primaryButton: DSAlertButton(
                    title: "Delete",
                    style: .destructive
                ) {
                    print("Item deleted")
                },
                secondaryButton: DSAlertButton(
                    title: "Cancel",
                    style: .secondary
                ) {
                    print("Action cancelled")
                }
            )
        )
    }
    
    // MARK: - Alert Types
    private var alertTypesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Alert Types")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSButton(
                    title: "Show Default Alert",
                    style: .primary
                ) {
                    showDefaultAlert = true
                }
                
                DSButton(
                    title: "Show Success Alert",
                    style: .primary
                ) {
                    showSuccessAlert = true
                }
                
                DSButton(
                    title: "Show Error Alert",
                    style: .primary
                ) {
                    showErrorAlert = true
                }
                
                DSButton(
                    title: "Show Warning Alert",
                    style: .primary
                ) {
                    showWarningAlert = true
                }
                
                DSButton(
                    title: "Show Confirmation Alert",
                    style: .primary
                ) {
                    showConfirmationAlert = true
                }
            }
        }
    }
    
    // MARK: - Alert with Actions
    private var alertWithActionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Alert with Actions")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Alerts can have primary and secondary buttons with different styles and actions.")
                .foregroundColor(.secondary)
        }
    }
    
    // MARK: - Alert Styles
    private var alertStylesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Alert Styles")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Different alert styles provide visual feedback: success (green), error (red), warning (orange), and default (blue).")
                .foregroundColor(.secondary)
        }
    }
}

struct AlertExamples_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlertExamples()
        }
    }
} 