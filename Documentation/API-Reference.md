# API Reference

## Core Classes

### Main Framework

The main entry point for the SwiftUI-Design-System-Pro framework.

```swift
public class SwiftUI-Design-System-Pro {
    public init()
    public func configure()
    public func reset()
}
```

## Configuration

### Options

```swift
public struct Configuration {
    public var debugMode: Bool
    public var logLevel: LogLevel
    public var cacheEnabled: Bool
}
```

## Error Handling

```swift
public enum SwiftUI-Design-System-ProError: Error {
    case configurationFailed
    case initializationError
    case runtimeError(String)
}
