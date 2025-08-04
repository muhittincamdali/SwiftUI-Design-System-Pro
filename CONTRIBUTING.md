# 🤝 Contributing Guidelines

<div align="center">

**🌟 Want to contribute to this project?**

[📋 Code of Conduct](CODE_OF_CONDUCT.md) • [🐛 Bug Report](https://github.com/muhittincamdali/SwiftUI-Design-System-Pro/issues) • [💡 Feature Request](https://github.com/muhittincamdali/SwiftUI-Design-System-Pro/issues)

</div>

---

## 🎯 Contribution Types

### 🐛 Bug Reports
- **Clear and concise** description
- **Reproducible** steps
- **Expected vs Actual** behavior
- **Environment** information (iOS version, Xcode version)
- **Screenshots/GIFs** (if possible)

### 💡 Feature Requests
- **Problem** description
- **Proposed solution** suggestion
- **Use case** scenarios
- **Mockups/wireframes** (if possible)

### 📚 Documentation
- **README** updates
- **Code comments** improvements
- **Architecture** documentation
- **Tutorial** writing

### 🧪 Tests
- **Unit tests** addition
- **Integration tests** writing
- **UI tests** creation
- **Performance tests** addition

---

## 🚀 Contribution Process

### 1. 🍴 Fork & Clone
```bash
# Fork the repository
# Then clone
git clone https://github.com/YOUR_USERNAME/SwiftUI-Design-System-Pro.git
cd SwiftUI-Design-System-Pro
```

### 2. 🌿 Create Branch
```bash
# Feature branch
git checkout -b feature/amazing-feature

# Bug fix branch
git checkout -b fix/bug-description

# Documentation branch
git checkout -b docs/update-readme
```

### 3. 🔧 Development
```bash
# Open in Xcode
open SwiftUI-Design-System-Pro.xcodeproj
```

### 4. ✅ Test
```bash
# Unit tests
xcodebuild test -project SwiftUI-Design-System-Pro.xcodeproj -scheme SwiftUI-Design-System-Pro -destination 'platform=iOS Simulator,name=iPhone 15'

# UI tests
xcodebuild test -project SwiftUI-Design-System-Pro.xcodeproj -scheme SwiftUI-Design-System-Pro -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:SwiftUI-Design-System-ProUITests
```

### 5. 📝 Commit
```bash
# Use conventional commits
git commit -m "feat: add new button component"
git commit -m "fix: resolve memory leak in image loading"
git commit -m "docs: update component documentation"
git commit -m "test: add unit tests for button component"
```

### 6. 🚀 Push & Pull Request
```bash
# Push
git push origin feature/amazing-feature

# Create Pull Request
# Click "Compare & pull request" on GitHub
```

---

## 📋 Pull Request Template

### 🎯 PR Title
```
feat: add new button component with accessibility support
fix: resolve memory leak in image caching
docs: update getting started guide
test: add comprehensive unit tests
```

### 📝 PR Description
```markdown
## 🎯 Change Type
- [ ] 🐛 Bug fix
- [ ] ✨ New feature
- [ ] 📚 Documentation
- [ ] 🧪 Tests
- [ ] 🔧 Refactoring
- [ ] ⚡ Performance improvement
- [ ] 🔒 Security enhancement

## 📋 Change Description
This PR includes the following changes:

- New button component with accessibility support
- Dark/Light mode compatibility
- Unit tests for all scenarios
- Documentation updates

## 🧪 Tested
- [ ] Unit tests pass
- [ ] UI tests pass
- [ ] Manual testing completed
- [ ] Performance tests pass

## 📸 Screenshots (for UI changes)
![Screenshot](url-to-screenshot)

## 🔗 Related Issue
Closes #123

## ✅ Checklist
- [ ] Code follows design system guidelines
- [ ] SOLID principles applied
- [ ] Error handling added
- [ ] Logging added
- [ ] Documentation updated
- [ ] Tests added
- [ ] Performance optimized
```

---

## 🎨 Code Standards

### 📱 Swift Style Guide
```swift
// ✅ Correct
struct DSButton: View {
    let title: String
    let style: DSButtonStyle
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(style)
    }
}

// ❌ Wrong
struct DSButton:View{
    let title:String
    let style:DSButtonStyle
    let action:()->Void
    var body:some View{
        Button(title,action:action)
            .buttonStyle(style)
    }
}
```

### 🎨 Design System Standards
```swift
// ✅ Design System Component
struct DSButton: View {
    let title: String
    let style: DSButtonStyle
    let size: DSButtonSize
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(style)
            .frame(height: size.height)
            .accessibilityLabel(title)
    }
}

// ✅ Theme Support
struct DSButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(title, action: action)
            .background(colorScheme == .dark ? Color.darkBackground : Color.lightBackground)
    }
}
```

### 🧪 Test Standards
```swift
// ✅ Unit Test
class DSButtonTests: XCTestCase {
    func testPrimaryButtonRendering() {
        // Given
        let button = DSButton(
            title: "Test",
            style: .primary,
            action: {}
        )
        
        // When
        let view = button.body
        
        // Then
        XCTAssertNotNil(view)
    }
}
```

---

## 🔧 Development Environment

### 📋 Requirements
- **Xcode 14.0+**
- **iOS 15.0+**
- **Swift 5.7+**
- **SwiftUI 3.0+**

### ⚙️ Setup
```bash
# 1. Clone repository
git clone https://github.com/muhittincamdali/SwiftUI-Design-System-Pro.git

# 2. Open in Xcode
open SwiftUI-Design-System-Pro.xcodeproj
```

### 🧪 Test Running
```bash
# Unit tests
xcodebuild test -project SwiftUI-Design-System-Pro.xcodeproj -scheme SwiftUI-Design-System-Pro

# UI tests
xcodebuild test -project SwiftUI-Design-System-Pro.xcodeproj -scheme SwiftUI-Design-System-Pro -only-testing:SwiftUI-Design-System-ProUITests
```

---

## 📚 Documentation Standards

### 📝 Code Comments
```swift
/**
 * Design System Button Component
 * 
 * A customizable button component that follows the design system guidelines.
 * Supports multiple styles, sizes, and accessibility features.
 * 
 * - Parameters:
 *   - title: Button text
 *   - style: Button style (primary, secondary, tertiary)
 *   - size: Button size (small, medium, large)
 *   - action: Button tap action
 * 
 * - Returns: SwiftUI View
 * 
 * - Example:
 * ```swift
 * DSButton(
 *     title: "Get Started",
 *     style: .primary,
 *     action: { print("Button tapped") }
 * )
 * ```
 */
struct DSButton: View {
    // Implementation
}
```

### 📖 README Updates
- **New features** documentation
- **API changes** migration guide
- **Performance improvements** benchmark results
- **Security updates** security notes

---

## 🎯 Contribution Priorities

### 🔥 High Priority
- **Security vulnerabilities** fixes
- **Critical bugs** solutions
- **Performance issues** optimizations
- **Crash fixes** fixes

### 🚀 Medium Priority
- **New features** addition
- **UI/UX improvements** enhancements
- **Documentation** updates
- **Test coverage** increase

### 📚 Low Priority
- **Code refactoring** improvements
- **Minor UI changes** small changes
- **Documentation** fixes
- **Code comments** improvements

---

## 🌟 Contributors

<div align="center">

**Thank you to everyone who contributes to this project!**

[![Contributors](https://contrib.rocks/image?repo=muhittincamdali/SwiftUI-Design-System-Pro)](https://github.com/muhittincamdali/SwiftUI-Design-System-Pro/graphs/contributors)

</div>

---

## 📞 Contact

- **Issues**: [GitHub Issues](https://github.com/muhittincamdali/SwiftUI-Design-System-Pro/issues)
- **Discussions**: [GitHub Discussions](https://github.com/muhittincamdali/SwiftUI-Design-System-Pro/discussions)
- **Email**: your-email@example.com
- **Twitter**: [@your-twitter](https://twitter.com/your-twitter)

---

<div align="center">

**🌟 Thank you for contributing!**

**🎨 World's Most Comprehensive SwiftUI Design System**

</div> 