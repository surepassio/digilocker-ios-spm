# DigilockerSDK - Binary SPM Package

A Swift Package Manager library for Digilocker integration in iOS applications using binary XCFramework distribution.

## ⚠️ Current Status

**v1.0.0 binary release** - XCFramework binary is being prepared. The current Package.swift contains placeholder URLs that will be updated once the binary is ready.

## 🔒 Privacy-First Approach

This package uses **binary distribution only** - source code remains private while providing full SDK functionality.

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/surepassio/digilocker-ios-spm.git", from: "1.0.0")
]
```

Or add it through Xcode:
1. File → Add Package Dependencies
2. Enter the repository URL: `https://github.com/surepassio/digilocker-ios-spm`
3. Select version: `1.0.0` or later

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## Usage

### Basic Integration

```swift
import SwiftUI
import DigilockerSDK

struct ContentView: View {
    @State private var errorMessage = ""
    @State private var token = "your_token"
    let env = "production" // or "sandbox"
    
    var body: some View {
        VStack {
            InitSDKView(
                environment: env,
                token: token,
                onCompletion: { clientId in
                    print("SDK SUCCESS: ", clientId)
                    errorMessage = ""
                    token = clientId
                },
                onFailure: { result in
                    print("SDK ERROR: ", result)
                    errorMessage = result
                }
            )
            
            if !errorMessage.isEmpty {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
}
```

### Using DigilockerView Alias

```swift
import SwiftUI
import DigilockerSDK

struct ContentView: View {
    var body: some View {
        DigilockerView(
            environment: "production",
            token: "your_token",
            onCompletion: { clientId in
                print("Success:", clientId)
            },
            onFailure: { error in
                print("Error:", error)
            }
        )
    }
}
```

### Configuration

```swift
// Configure the SDK (call this once during app initialization)
DigilockerSDK.configure()
```

## Available APIs

- `InitSDKView` - Main SDK view component
- `DigilockerView` - Alias for InitSDKView
- `DigilockerSDK.configure()` - SDK configuration

## Development

### Building Binary Release

This repository uses binary distribution to keep source code private. To build a new release:

```bash
./build.sh
```

This will:
- Build XCFramework from private source
- Update Package.swift with correct checksum
- Create and push new binary release

### Opening Workspace

```bash
open DigilockerSDK.xcworkspace
```

The workspace provides a clean environment for managing the binary SPM package.

## License

See LICENSE file for details.

## Support

For support and documentation, please contact the Surepass team.