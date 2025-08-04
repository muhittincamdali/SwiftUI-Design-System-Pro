import SwiftUI

struct TextFieldExamples: View {
    @State private var email = ""
    @State private var password = ""
    @State private var phone = ""
    @State private var name = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Basic Text Fields
                basicTextFieldsSection
                
                // Validation Text Fields
                validationTextFieldsSection
                
                // Styled Text Fields
                styledTextFieldsSection
                
                // Sized Text Fields
                sizedTextFieldsSection
                
                // Secure Text Fields
                secureTextFieldsSection
            }
            .padding()
        }
        .navigationTitle("Text Field Examples")
    }
    
    // MARK: - Basic Text Fields
    private var basicTextFieldsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Basic Text Fields")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSTextField(
                    placeholder: "Enter your name",
                    text: $name
                )
                
                DSTextField(
                    placeholder: "Enter your email",
                    text: $email
                )
                
                DSTextField(
                    placeholder: "Enter your phone number",
                    text: $phone
                )
            }
        }
    }
    
    // MARK: - Validation Text Fields
    private var validationTextFieldsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Validation Text Fields")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSTextField(
                    placeholder: "Enter email",
                    text: $email,
                    validation: .email
                )
                
                DSTextField(
                    placeholder: "Enter phone number",
                    text: $phone,
                    validation: .phone
                )
                
                DSTextField(
                    placeholder: "Enter password",
                    text: $password,
                    validation: .password
                )
            }
        }
    }
    
    // MARK: - Styled Text Fields
    private var styledTextFieldsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Styled Text Fields")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSTextField(
                    placeholder: "Primary style",
                    text: $name,
                    style: .primary
                )
                
                DSTextField(
                    placeholder: "Secondary style",
                    text: $name,
                    style: .secondary
                )
            }
        }
    }
    
    // MARK: - Sized Text Fields
    private var sizedTextFieldsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Sized Text Fields")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSTextField(
                    placeholder: "Small text field",
                    text: $name,
                    size: .small
                )
                
                DSTextField(
                    placeholder: "Medium text field",
                    text: $name,
                    size: .medium
                )
                
                DSTextField(
                    placeholder: "Large text field",
                    text: $name,
                    size: .large
                )
            }
        }
    }
    
    // MARK: - Secure Text Fields
    private var secureTextFieldsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Secure Text Fields")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSTextField(
                    placeholder: "Enter password",
                    text: $password,
                    isSecure: true
                )
                
                DSTextField(
                    placeholder: "Enter confirm password",
                    text: $password,
                    isSecure: true,
                    validation: .password
                )
            }
        }
    }
}

struct TextFieldExamples_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TextFieldExamples()
        }
    }
} 