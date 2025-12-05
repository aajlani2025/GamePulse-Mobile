# Movesense App

A Flutter-based BLE gateway application that collects sensor data from multiple Movesense wearable devices and streams it to n8n in real-time.

## Overview

This app acts as a data aggregation bridge between Movesense fitness/health sensors and n8n. It discovers, connects, and streams data from multiple devices simultaneously via WebSocket.

## Features

- **Multi-device support**: Connect and stream data from multiple Movesense sensors at once
- **Dual data streams**:
  - Heart Rate (HR) measurements
  - IMU9 inertial data at 104 Hz (accelerometer, gyroscope, magnetometer)
- **Real-time WebSocket streaming**: Sends sensor data to n8n
- **Automatic reconnection**: 3-second retry logic for dropped connections
- **Session tracking**: Organizes data with session IDs

## Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **BLE Communication**: mdsflutter (Movesense native plugin)
- **Data Visualization**: fl_chart
- **Networking**: web_socket_channel

## Setup Instructions (After Cloning)

Follow these exact steps to run the app on a new machine:

### 1. Install Flutter

1. Download the latest **stable** Flutter SDK for macOS from https://docs.flutter.dev/get-started/install
2. Unzip it to a permanent location (e.g., `~/development/flutter`)
3. Add Flutter to your PATH by editing `~/.zshrc`:
   ```bash
   export PATH="$PATH:$HOME/development/flutter/bin"
   ```
4. Restart your terminal
5. Run `flutter doctor` to complete initial setup

### 2. Install Xcode

1. Install Xcode from the Mac App Store
2. Open Xcode once and accept the license agreement
3. Go to **Xcode → Preferences → Locations** and select a Command Line Tools version
4. Sign in with your Apple ID in Xcode (required for device builds)

### 3. Install CocoaPods

```bash
sudo gem install cocoapods
```
or
```bash
brew install cocoapods
```

### 4. Install Project Dependencies

```bash
cd movesense_app
flutter pub get
cd ios
pod install
cd ..
```

### 5. Configure WebSocket Endpoint

Edit `lib/services/websocket_service.dart` and update the WebSocket URL to point to your n8n instance.

### 6. Verify Setup

```bash
flutter doctor -v
```

Make sure there are no critical issues (warnings are okay).

### 7. Run the App

Connect an iOS device or start the iOS Simulator, then:

```bash
flutter run
```

## Usage

1. Launch the app
2. Press **START** to begin scanning for Movesense devices
3. The app will automatically connect to discovered sensors
4. Sensor data streams in real-time to the configured WebSocket endpoint
5. Press **STOP** to disconnect all devices and stop streaming

## Project Structure

```
lib/
├── main.dart              # App entry point
├── models/
│   └── sensor_data.dart   # Data model for sensor readings
├── screens/
│   └── home_screen.dart   # Main UI with START/STOP controls
└── services/
    ├── movesense_service.dart  # BLE discovery and connection logic
    └── websocket_service.dart  # WebSocket communication
```

## Data Format

The app streams two types of sensor data via WebSocket:

**Heart Rate**:
```json
{
  "sensor_id": "...",
  "session_id": "...",
  "gateway_time": 1701234567890,
  "rawData": { "average": 75, "rrData": [...] }
}
```

**IMU (Inertial Measurement Unit)**:
```json
{
  "sensor_id": "...",
  "session_id": "...",
  "rawData": {
    "Timestamp": 12345,
    "ArrayAcc": [...],
    "ArrayGyro": [...],
    "ArrayMagn": [...]
  }
}
```

## Current Testing Status

The WebSocket streaming to n8n is currently commented out. This version is for testing the other features:
- BLE scanning and device discovery
- Sensor connection and data subscription
- HR and IMU data reception
- UI controls (START/STOP)

## License

This project is proprietary. All rights reserved.
