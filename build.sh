#!/bin/bash

# DigilockerSDK XCFramework Build Script - Build from Sources and push to GitHub
set -e

echo "🚀 Building DigilockerSDK XCFramework from Sources..."

# Configuration
BUILD_DIR="build"
FRAMEWORK_NAME="DigilockerSDK"
VERSION="v1.0.0"

# Configuration - Private source location (NOT in GitHub)
PRIVATE_SOURCE_PATH="/Users/alishkumar/Documents/SPM/Digilocker-iOS-App"

# Check if private source exists
if [ ! -d "$PRIVATE_SOURCE_PATH" ]; then
    echo "❌ Private source not found at: $PRIVATE_SOURCE_PATH"
    echo "📋 Update PRIVATE_SOURCE_PATH in build.sh to your source location"
    exit 1
fi

# Check for xcodebuild
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ xcodebuild not found. Install with: xcode-select --install"
    exit 1
fi

# Clean and create build directory
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR/archives

echo "📦 Building XCFramework from private source (NOT in GitHub)..."
cd "$PRIVATE_SOURCE_PATH"

# Build for iOS
xcodebuild archive \
    -project "DigilockerSDK.xcodeproj" \
    -scheme "DigilockerSDK" \
    -destination "generic/platform=iOS" \
    -archivePath "$BUILD_DIR/archives/DigilockerSDK-iOS.xcarchive" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Build for iOS Simulator  
xcodebuild archive \
    -project "DigilockerSDK.xcodeproj" \
    -scheme "DigilockerSDK" \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "$BUILD_DIR/archives/DigilockerSDK-iOS-Simulator.xcarchive" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Create XCFramework
xcodebuild -create-xcframework \
    -archive "$BUILD_DIR/archives/DigilockerSDK-iOS.xcarchive" -framework "DigilockerSDK.framework" \
    -archive "$BUILD_DIR/archives/DigilockerSDK-iOS-Simulator.xcarchive" -framework "DigilockerSDK.framework" \
    -output "$BUILD_DIR/DigilockerSDK.xcframework"

# Copy XCFramework to SPM directory
cd "/Users/alishkumar/Documents/digilocker-ios-spm"
cp -R "$PRIVATE_SOURCE_PATH/$BUILD_DIR/DigilockerSDK.xcframework" "$BUILD_DIR/"

# Create zip
cd $BUILD_DIR
zip -r "DigilockerSDK.xcframework.zip" "DigilockerSDK.xcframework"
cd ..

# Calculate checksum
CHECKSUM=$(swift package compute-checksum "$BUILD_DIR/DigilockerSDK.xcframework.zip")
echo "✅ Checksum: $CHECKSUM"

# Update Package.swift to binary target with real checksum
cat > Package.swift << EOF
// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "DigilockerSDK",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "DigilockerSDK", targets: ["DigilockerSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "DigilockerSDK",
            url: "https://github.com/surepassio/digilocker-ios-spm/releases/download/$VERSION/DigilockerSDK.xcframework.zip",
            checksum: "$CHECKSUM"
        ),
    ]
)
EOF

# Update Package.swift with binary target (NO Sources in GitHub)
echo "📝 Updating Package.swift to binary target..."

# Commit and push ONLY the XCFramework and Package.swift (NO Sources)
git add Package.swift build/
git commit -m "Add XCFramework binary - Sources remain private"
git tag -f v1.1.0
git push origin master
git push origin v1.1.0 --force

echo "✅ XCFramework created and pushed!"
echo "🔒 Sources NOT in GitHub - kept private locally"
echo "📋 Next: Upload build/DigilockerSDK.xcframework.zip to GitHub releases v1.1.0"
echo "🎯 Public gets XCFramework access, source code stays private"