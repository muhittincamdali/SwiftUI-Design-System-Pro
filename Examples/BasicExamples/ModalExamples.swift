import SwiftUI

struct ModalExamples: View {
    @State private var showSheetModal = false
    @State private var showCenterModal = false
    @State private var showFullScreenModal = false
    @State private var showCustomModal = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Modal Types
                modalTypesSection
                
                // Modal with Content
                modalWithContentSection
                
                // Modal with Actions
                modalWithActionsSection
            }
            .padding()
        }
        .navigationTitle("Modal Examples")
        .overlay(
            // Sheet Modal
            DSModal(
                isPresented: $showSheetModal,
                title: "Sheet Modal",
                style: .sheet
            ) {
                VStack(spacing: 20) {
                    Text("This is a sheet modal that slides up from the bottom.")
                        .multilineTextAlignment(.center)
                    
                    DSButton(
                        title: "Close",
                        style: .primary
                    ) {
                        showSheetModal = false
                    }
                }
            }
        )
        .overlay(
            // Center Modal
            DSModal(
                isPresented: $showCenterModal,
                title: "Center Modal",
                style: .center
            ) {
                VStack(spacing: 20) {
                    Text("This is a center modal that appears in the middle of the screen.")
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 12) {
                        DSButton(
                            title: "Cancel",
                            style: .secondary
                        ) {
                            showCenterModal = false
                        }
                        
                        DSButton(
                            title: "Confirm",
                            style: .primary
                        ) {
                            showCenterModal = false
                        }
                    }
                }
            }
        )
        .overlay(
            // Full Screen Modal
            DSModal(
                isPresented: $showFullScreenModal,
                title: "Full Screen Modal",
                style: .fullScreen
            ) {
                VStack(spacing: 20) {
                    Text("This is a full screen modal that covers the entire screen.")
                        .multilineTextAlignment(.center)
                    
                    DSButton(
                        title: "Close",
                        style: .primary
                    ) {
                        showFullScreenModal = false
                    }
                }
            }
        )
        .overlay(
            // Custom Modal
            DSModal(
                isPresented: $showCustomModal,
                title: "Custom Modal",
                style: .center,
                onDismiss: {
                    print("Custom modal dismissed")
                }
            ) {
                VStack(spacing: 20) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.yellow)
                    
                    Text("Custom Modal Content")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("This modal has custom content with an icon and custom styling.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                    
                    DSButton(
                        title: "Got it!",
                        style: .primary
                    ) {
                        showCustomModal = false
                    }
                }
            }
        )
    }
    
    // MARK: - Modal Types
    private var modalTypesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Modal Types")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSButton(
                    title: "Show Sheet Modal",
                    style: .primary
                ) {
                    showSheetModal = true
                }
                
                DSButton(
                    title: "Show Center Modal",
                    style: .secondary
                ) {
                    showCenterModal = true
                }
                
                DSButton(
                    title: "Show Full Screen Modal",
                    style: .tertiary
                ) {
                    showFullScreenModal = true
                }
                
                DSButton(
                    title: "Show Custom Modal",
                    style: .primary
                ) {
                    showCustomModal = true
                }
            }
        }
    }
    
    // MARK: - Modal with Content
    private var modalWithContentSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Modal with Content")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Tap the buttons above to see different types of modals with various content and styling options.")
                .foregroundColor(.secondary)
        }
    }
    
    // MARK: - Modal with Actions
    private var modalWithActionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Modal with Actions")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Modals can include buttons, forms, images, and any other SwiftUI content. They support all design system components.")
                .foregroundColor(.secondary)
        }
    }
}

struct ModalExamples_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ModalExamples()
        }
    }
} 