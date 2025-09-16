# DigilockerSDK

DigilockerSDK is a Swift Package Manager SDK for seamless Digilocker identity verification integration.

## 🚀 Quick Overview

The Digiboost SDK enables secure document verification and digital identity services in your iOS app. Follow this guide to get up and running in minutes.

DigilockerSDK helps developers integrate secure identity verification using Digilocker services. It provides a complete UI flow for user authentication and document verification with a simple, modern interface.

**Note:** We make continuous enhancements to our SDK and security capabilities which includes new functionalities, bug fixes and security updates. We recommend updating to the latest SDK version to ensure optimal security and performance.

## Table of Contents

- [🚀 Quick Overview](#-quick-overview)
- [📋 Table of Contents](#table-of-contents)
- [🔑 Step 1: Generating Your SDK Token](#step-1-generating-your-sdk-token)
  - [1.1 Get API Details from Your Sales Manager](#11-get-api-details-from-your-sales-manager)
  - [1.2 Environment Configuration](#12-environment-configuration)
  - [1.3 Digilocker Initialize API](#13-digilocker-initialize-api)
  - [1.4 API Parameters Explanation](#14-api-parameters-explanation)
  - [1.5 Customization Examples](#15-customization-examples)
  - [1.6 API Response](#16-api-response)
- [📦 Step 2: Installation](#step-2-installation)
  - [Swift Package Manager](#swift-package-manager)
- [🚀 Step 3: Quick Start](#step-3-quick-start)
  - [Basic Integration](#basic-integration)
  - [Environment Configuration](#environment-configuration)
  - [Custom Integration](#custom-integration)
- [📥 Step 4: Download Aadhaar](#step-4-download-aadhaar)
  - [4.1 Download Aadhaar API](#41-download-aadhaar-api)
  - [4.2 API Parameters](#42-api-parameters)
  - [4.3 API Response](#43-api-response)
- [✨ Features](#features)
- [📚 API Reference](#api-reference)
  - [DigilockerSDK](#digilockersdk)
  - [InitSDKView](#initsdkview)
  - [Env](#env)
- [⚠️ Error Handling](#️-error-handling)
- [🔧 Troubleshooting](#-troubleshooting)
  - [Common Issues](#common-issues)
- [💻 Requirements](#-requirements)
- [📝 Version](#-version)
  - [Changelog](#changelog)
- [📄 License](#-license)
- [🆘 Support](#-support)

## 🔑 Step 1: Generating Your SDK Token

Before integrating the SDK, you need to obtain an authentication token from the Digiboost API.

### 1.1 Get API Details from Your Sales Manager

Contact your sales manager to receive:

- Digilocker initialize endpoint URL
- Authorization Bearer Token (required for API access)
- Access permissions

🎥 **Watch Video Tutorial For Generating SDK Token** .

### 1.2 Environment Configuration

We provide two environments for different stages of development:

| Environment | Base URL | Usage |
|-------------|----------|-------|
| UAT (Testing) | `https://sandbox.surepass.app` | For development and testing |
| Production | `https://kyc-api.surepass.app` | For live applications |

### 1.3 Digilocker Initialize API

**For UAT Environment:**

```bash
curl --location 'https://sandbox.surepass.app/api/v1/digilocker/initialize' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer TOKEN_GOT_FROM_SALES_MANAGER' \
--data '{
    "data": {
        "signup_flow": true,
        "auth_type": "app",
        "logo_url": "YOUR BRAND LOGO URL",
        "voice_assistant_lang": "en",
        "voice_assistant": false,
        "retry_count": 2,
        "skip_main_screen": false
    }
}'
```

**For Production Environment:**

```bash
curl --location 'https://kyc-api.surepass.app/api/v1/digilocker/initialize' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer TOKEN_GOT_FROM_SALES_MANAGER' \
--data '{
    "data": {
        "signup_flow": true,
        "auth_type": "app",
        "logo_url": "YOUR BRAND LOGO URL",
        "voice_assistant_lang": "en",
        "voice_assistant": false,
        "retry_count": 2,
        "skip_main_screen": false
    }
}'
```

### 1.4 API Parameters Explanation

| Parameter | Type | Required | Description | Default Value |
|-----------|------|----------|-------------|---------------|
| `signup_flow` | boolean | ✅ Required | This parameter should always be true for SDK initialization | `true` |
| `auth_type` | string | ✅ Required | Authentication type for the SDK. Must be set to "app" | `"app"` |
| `logo_url` | string | ❌ Optional | Your branding logo URL - customize with your own logo | None |
| `voice_assistant_lang` | string | ❌ Optional | Voice assistant language. Possible options: "en" (English), "hi" (Hindi) | `"en"` |
| `voice_assistant` | boolean | ❌ Optional | Enable/disable voice assistant functionality | `false` |
| `retry_count` | integer | ❌ Optional | Number of allowed retries during dropout prevention | `2` |
| `skip_main_screen` | boolean | ❌ Optional | Whether to show the first intro screen or skip it | `true` |

### 1.5 Customization Examples

**Basic Configuration (Minimal):**

```json
{
    "data": {
        "signup_flow": true,
        "auth_type": "app"
    }
}
```

**Custom Branding with Voice Assistant:**

```json
{
    "data": {
        "signup_flow": true,
        "auth_type": "app",
        "logo_url": "https://yourcompany.com/logo.png",
        "voice_assistant_lang": "hi",
        "voice_assistant": true,
        "retry_count": 3,
        "skip_main_screen": false
    }
}
```

### 1.6 API Response

You'll receive a response like this:

```json
{
  "data": {
    "client_id": "digilocker_cntWpMxWHbcvgghtyvxw",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expiry_seconds": 600.0
  },
  "status_code": 200,
  "message_code": "success",
  "message": "Success",
  "success": true
}
```

**Important:**

- Copy the `token` value - you'll need this for Step 3!
- The token expires in 600 seconds (10 minutes) by default
- Store the `client_id` if needed for tracking purposes

## ✨ Features

- 🔐 **Secure Identity Verification** - Complete Digilocker integration
- 📱 **Native SwiftUI Interface** - Modern, responsive UI components  
- ⚡ **Simple Integration** - Just a few lines of code to get started
- 🎯 **Auto-dismiss Flow** - Handles navigation and lifecycle automatically
- 🛡️ **Production Ready** - Built for commercial applications

## 📦 Step 2: Installation

### Swift Package Manager

**Xcode Integration:**
1. File → Add Package Dependencies
2. Enter: `https://github.com/surepassio/digilocker-ios-spm`
3. Select version and add to target

**Package.swift:**
```swift
dependencies: [
    .package(url: "https://github.com/surepassio/digilocker-ios-spm", from: "1.0.0")
]
```

## 🚀 Step 3: Quick Start

### Basic Integration

Use the token you received from Step 1:

```swift
import Digilocker_Framework
import SwiftUI

```swift
struct MyVerificationView: View {
    var body: some View {
        InitSDKView(
            environment: Env.SANDBOX.rawValue,
            token: "your-token"
        ) { clientId in
            // Success callback
            handleSuccess(clientId)
        } onFailure: { errorMessage in
            // Error callback
            handleError(errorMessage)
        }
    }
    
    func handleSuccess(_ clientId: String) {
        // Process successful verification
    }
    
    func handleError(_ errorMessage: String) {
        // Handle errors
    }
}
```

### Theme Customization

You can customize the SDK's accent color to match your app's branding:

```swift
import Digilocker_Framework

// Set your custom accent color before initializing the SDK
SurepassConfig.shared.accentColor = .blue
// You can use any UIColor: .red, .green, .purple, UIColor(hex: "#FF6B35"), etc.

```

## 📥 Step 4: Download Aadhaar

After successful verification through the SDK, you can download the Aadhaar document using the Download Aadhaar API.

### 4.1 Download Aadhaar API

Use the client_id received from the SDK success callback to download the Aadhaar document.

**For UAT Environment:**

```bash
curl --location 'https://sandbox.surepass.app/api/v1/digilocker/download-aadhaar' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer TOKEN_GOT_FROM_SALES_MANAGER' \
--data '{
    "client_id": "CLIENT_ID_FROM_SDK_SUCCESS_CALLBACK"
}'
```

**For Production Environment:**

```bash
curl --location 'https://kyc-api.surepass.app/api/v1/digilocker/download-aadhaar' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer TOKEN_GOT_FROM_SALES_MANAGER' \
--data '{
    "client_id": "CLIENT_ID_FROM_SDK_SUCCESS_CALLBACK"
}'
```

### 4.2 API Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|--------------|
| `client_id` | string | ✅ Required | The client ID received from the SDK success callback after verification |

### 4.3 API Response

**Success Response:**

```json
{
  "data": {
    "aadhaar_pdf": "base64_encoded_pdf_data",
    "aadhaar_xml": "base64_encoded_xml_data",
    "name": "John Doe",
    "aadhaar_number": "XXXX-XXXX-1234",
    "date_of_birth": "01-01-1990",
    "gender": "M",
    "address": {
      "house": "123",
      "street": "Main Street",
      "landmark": "Near Park",
      "locality": "Central Area",
      "vtc": "City Name",
      "district": "District Name",
      "state": "State Name",
      "pincode": "123456"
    }
  },
  "status_code": 200,
  "message_code": "success",
  "message": "Aadhaar downloaded successfully",
  "success": true
}
```

**Error Response:**

```json
{
  "data": null,
  "status_code": 400,
  "message_code": "error",
  "message": "Invalid client_id or verification not completed",
  "success": false
}
```

**Important Notes:**
- The `client_id` must be from a successfully completed verification
- PDF and XML data are base64 encoded and need to be decoded before use
- Store the downloaded data securely according to your compliance requirements
- The API response includes both the document files and extracted user information

### Env

Environment enumeration for API endpoints.

```swift
public enum Env: String {
    case PROD
    case SANDBOX
}
```

## ⚠️ Error Handling

The SDK provides simple error handling through the `onFailure` callback:

```swift
onFailure: { errorMessage in
    // Handle verification errors
    print("Verification failed: \(errorMessage)")
}
```

### Features:
- **Auto-dismiss:** SDK automatically closes on success or failure
- **Simple callbacks:** Clean success/error handling  
- **SwiftUI integration:** Seamless navigation flow

## 🔧 Troubleshooting

### Common Issues

**Assets not loading:**
- Ensure you're using the latest version (1.0.0+)
- Check that your integration follows the exact code examples above

**SDK not responding:**
- Verify your API token is valid for the environment (SANDBOX/PROD)
- Check network connectivity and firewall settings

**Build errors:**
- Ensure iOS deployment target is 15.0 or higher
- Clean build folder and rebuild if needed

For additional support, contact techsupport@surepass.app with your integration details.

## 💻 Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## 📝 Version

Current Version: **1.0.0**

### Changelog

- **v1.0.0** - Initial release with complete Digilocker integration

## 📄 License

This SDK is distributed under a commercial license. Contact techsupport@surepass.app for licensing information.

## 🆘 Support

- **Email:** techsupport@surepass.app
- **Documentation:** [Please find the Documentation Link](https://console.surepass.app/product/console/api-lists?active=16301914&leafId=16301914&path=%2Fdocs%2Fkyc%2Finitialize-16301914e0&expanded=3588860%2C3588870)
- **Website:** [Visit our Website Surepass.io](https://surepass.io)
- **Technical Support:** For integration assistance and troubleshooting

---

**🛡️ Powered by SurePass - Secure Identity Verification**
