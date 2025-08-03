import SwiftUI

struct AdvancedExamples: View {
    @State private var showModal = false
    @State private var showAlert = false
    @State private var searchText = ""
    @State private var email = ""
    @State private var progress = 0.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Complex Forms
                complexFormsSection
                
                // Interactive Components
                interactiveComponentsSection
                
                // Data Display
                dataDisplaySection
                
                // User Feedback
                userFeedbackSection
            }
            .padding()
        }
        .navigationTitle("Advanced Examples")
        .overlay(
            DSModal(
                isPresented: $showModal,
                title: "Advanced Modal"
            ) {
                VStack(spacing: 20) {
                    Text("This is an advanced modal with complex content")
                        .multilineTextAlignment(.center)
                    
                    DSCard(
                        title: "Modal Card",
                        subtitle: "Cards work inside modals too"
                    )
                    
                    DSButton(
                        title: "Close Modal",
                        style: .primary
                    ) {
                        showModal = false
                    }
                }
            }
        )
        .overlay(
            DSAlert(
                isPresented: $showAlert,
                title: "Advanced Alert",
                message: "This alert demonstrates advanced usage with custom actions",
                primaryButton: DSAlertButton(
                    title: "Confirm",
                    style: .primary
                ) {
                    print("Confirmed action")
                },
                secondaryButton: DSAlertButton(
                    title: "Cancel",
                    style: .secondary
                ) {
                    print("Cancelled action")
                }
            )
        )
    }
    
    // MARK: - Complex Forms
    private var complexFormsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Complex Forms")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 16) {
                DSTextField(
                    placeholder: "Enter your email",
                    text: $email,
                    validation: .email
                )
                
                DSSearchField(
                    placeholder: "Search products",
                    text: $searchText,
                    suggestions: ["iPhone", "iPad", "MacBook", "Apple Watch"]
                )
                
                HStack(spacing: 12) {
                    DSButton(
                        title: "Submit",
                        style: .primary
                    ) {
                        print("Form submitted")
                    }
                    
                    DSButton(
                        title: "Reset",
                        style: .secondary
                    ) {
                        email = ""
                        searchText = ""
                    }
                }
            }
        }
    }
    
    // MARK: - Interactive Components
    private var interactiveComponentsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Interactive Components")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 16) {
                DSCard(
                    title: "Interactive Card",
                    subtitle: "Tap to show modal"
                ) {
                    showModal = true
                }
                
                DSButton(
                    title: "Show Alert",
                    style: .warning
                ) {
                    showAlert = true
                }
                
                DSProgressIndicator(
                    progress: progress,
                    style: .linear,
                    showPercentage: true
                )
                
                Slider(value: $progress, in: 0...1)
                    .padding(.horizontal)
            }
        }
    }
    
    // MARK: - Data Display
    private var dataDisplaySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Data Display")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSCard(
                    title: "User Profile",
                    subtitle: "John Doe - iOS Developer",
                    image: "person.circle.fill"
                )
                
                HStack(spacing: 8) {
                    DSBadge(text: "Active", style: .success)
                    DSBadge(number: 5, style: .primary)
                    DSBadge(showDot: true, style: .warning)
                }
                
                DSProgressIndicator(
                    progress: 0.75,
                    style: .circular,
                    showPercentage: true
                )
            }
        }
    }
    
    // MARK: - User Feedback
    private var userFeedbackSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("User Feedback")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSButton(
                    title: "Success Feedback",
                    style: .primary
                ) {
                    // Simulate success
                    progress = 1.0
                }
                
                DSButton(
                    title: "Error Feedback",
                    style: .destructive
                ) {
                    // Simulate error
                    progress = 0.0
                }
                
                DSButton(
                    title: "Loading State",
                    style: .secondary
                ) {
                    // Simulate loading
                    withAnimation(.easeInOut(duration: 2)) {
                        progress = 0.5
                    }
                }
            }
        }
    }
}

struct AdvancedExamples_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AdvancedExamples()
        }
    }
} 