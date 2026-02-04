Pod::Spec.new do |s|
  s.name             = 'SwiftUIDesignSystemPro'
  s.version          = '1.0.0'
  s.summary          = 'Complete design system with tokens, components, and theming for SwiftUI.'
  s.description      = <<-DESC
    SwiftUIDesignSystemPro provides a complete design system for SwiftUI applications.
    Features include design tokens (colors, typography, spacing), pre-built components,
    theming support, dark mode, accessibility, and atomic design methodology.
  DESC

  s.homepage         = 'https://github.com/muhittincamdali/SwiftUI-Design-System-Pro'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Muhittin Camdali' => 'contact@muhittincamdali.com' }
  s.source           = { :git => 'https://github.com/muhittincamdali/SwiftUI-Design-System-Pro.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'
  s.osx.deployment_target = '12.0'
  s.tvos.deployment_target = '15.0'
  s.watchos.deployment_target = '8.0'

  s.swift_versions = ['5.9', '5.10', '6.0']
  s.source_files = 'Sources/**/*.swift'
  s.frameworks = 'Foundation', 'SwiftUI'
end
