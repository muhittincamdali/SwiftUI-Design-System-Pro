import XCTest
import SwiftUI
@testable import DesignSystemPro

class PerformanceTests: XCTestCase {
    
    func testButtonRenderingPerformance() {
        measure {
            for _ in 0..<1000 {
                _ = DSButton(title: "Performance Test") { }
            }
        }
    }
    
    func testCardRenderingPerformance() {
        measure {
            for _ in 0..<100 {
                _ = DSCard(
                    title: "Performance Test",
                    subtitle: "Subtitle"
                )
            }
        }
    }
    
    func testTextFieldRenderingPerformance() {
        measure {
            for _ in 0..<500 {
                _ = DSTextField(
                    placeholder: "Test",
                    text: .constant("")
                )
            }
        }
    }
    
    func testSearchFieldRenderingPerformance() {
        measure {
            for _ in 0..<500 {
                _ = DSSearchField(
                    placeholder: "Test",
                    text: .constant("")
                )
            }
        }
    }
    
    func testModalRenderingPerformance() {
        measure {
            for _ in 0..<100 {
                _ = DSModal(
                    isPresented: .constant(false)
                ) {
                    Text("Content")
                }
            }
        }
    }
    
    func testAlertRenderingPerformance() {
        measure {
            for _ in 0..<100 {
                _ = DSAlert(
                    isPresented: .constant(false),
                    title: "Test",
                    primaryButton: DSAlertButton(title: "OK")
                )
            }
        }
    }
    
    func testProgressIndicatorRenderingPerformance() {
        measure {
            for _ in 0..<200 {
                _ = DSProgressIndicator(progress: 0.5)
            }
        }
    }
    
    func testBadgeRenderingPerformance() {
        measure {
            for _ in 0..<1000 {
                _ = DSBadge(text: "Test")
            }
        }
    }
    
    func testMemoryUsage() {
        let initialMemory = getMemoryUsage()
        
        // Create many components
        var components: [Any] = []
        for _ in 0..<1000 {
            components.append(DSButton(title: "Test") { })
            components.append(DSCard(title: "Test", subtitle: "Subtitle"))
            components.append(DSTextField(placeholder: "Test", text: .constant("")))
        }
        
        let finalMemory = getMemoryUsage()
        let memoryIncrease = finalMemory - initialMemory
        
        // Should not increase memory by more than 50MB
        XCTAssertLessThan(memoryIncrease, 50 * 1024 * 1024)
    }
    
    func testAnimationPerformance() {
        measure {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                // Simulate animation
                for _ in 0..<100 {
                    _ = DSButton(title: "Animated") { }
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func getMemoryUsage() -> UInt64 {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size / MemoryLayout<natural_t>.size)
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        
        return info.resident_size
    }
} 