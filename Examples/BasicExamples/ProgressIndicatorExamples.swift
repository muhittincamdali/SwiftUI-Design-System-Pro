import SwiftUI

struct ProgressIndicatorExamples: View {
    @State private var linearProgress = 0.3
    @State private var circularProgress = 0.7
    @State private var determinateProgress = 0.5
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Progress Types
                progressTypesSection
                
                // Progress Sizes
                progressSizesSection
                
                // Progress Styles
                progressStylesSection
                
                // Interactive Progress
                interactiveProgressSection
            }
            .padding()
        }
        .navigationTitle("Progress Indicator Examples")
    }
    
    // MARK: - Progress Types
    private var progressTypesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Progress Types")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Linear Progress")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: linearProgress,
                        style: .linear,
                        showPercentage: true
                    )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Circular Progress")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: circularProgress,
                        style: .circular,
                        showPercentage: true
                    )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Determinate Progress")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: determinateProgress,
                        style: .determinate,
                        showPercentage: true
                    )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Indeterminate Progress")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: 0.0,
                        style: .indeterminate
                    )
                }
            }
        }
    }
    
    // MARK: - Progress Sizes
    private var progressSizesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Progress Sizes")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Small Progress")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: 0.4,
                        style: .linear,
                        size: .small
                    )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Medium Progress")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: 0.6,
                        style: .linear,
                        size: .medium
                    )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Large Progress")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: 0.8,
                        style: .linear,
                        size: .large
                    )
                }
            }
        }
    }
    
    // MARK: - Progress Styles
    private var progressStylesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Progress Styles")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Primary Style")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: 0.5,
                        style: .linear,
                        size: .medium
                    )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Success Style")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: 0.7,
                        style: .linear,
                        size: .medium
                    )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Warning Style")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: 0.3,
                        style: .linear,
                        size: .medium
                    )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Error Style")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: 0.9,
                        style: .linear,
                        size: .medium
                    )
                }
            }
        }
    }
    
    // MARK: - Interactive Progress
    private var interactiveProgressSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Interactive Progress")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Linear Progress: \(Int(linearProgress * 100))%")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: linearProgress,
                        style: .linear,
                        showPercentage: false
                    )
                    
                    Slider(value: $linearProgress, in: 0...1)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Circular Progress: \(Int(circularProgress * 100))%")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: circularProgress,
                        style: .circular,
                        showPercentage: false
                    )
                    
                    Slider(value: $circularProgress, in: 0...1)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Determinate Progress: \(Int(determinateProgress * 100))%")
                        .font(.headline)
                    
                    DSProgressIndicator(
                        progress: determinateProgress,
                        style: .determinate,
                        showPercentage: false
                    )
                    
                    Slider(value: $determinateProgress, in: 0...1)
                }
            }
        }
    }
}

struct ProgressIndicatorExamples_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProgressIndicatorExamples()
        }
    }
} 