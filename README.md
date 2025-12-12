# GamePulse Mobile

A Flutter-based BLE gateway application that collects sensor data from multiple Movesense wearable devices and streams it in real-time for sports analytics and performance monitoring.

## Overview

GamePulse Mobile acts as a data aggregation bridge between Movesense fitness/health sensors and backend services. It discovers, connects, and streams data from multiple devices simultaneously, enabling real-time athlete monitoring during training and games.

## Features

- **Multi-device Support**: Connect and stream data from multiple Movesense sensors simultaneously
- **Dual Data Streams**:
  - Heart Rate (HR) measurements with RR intervals
  - IMU9 inertial data at 104 Hz (accelerometer, gyroscope, magnetometer)
- **Real-time Visualization**: Live charts displaying sensor data as it arrives
- **Session Management**: Organize data collection with session IDs and events
- **Device Scanning**: BLE discovery with automatic device identification
- **Live Monitoring**: Real-time dashboard for all connected sensors
- **Debug Tools**: Device-level debugging screen for troubleshooting

## Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **BLE Communication**: mdsflutter (Movesense native plugin)
- **Data Visualization**: fl_chart
- **Networking**: HTTP/WebSocket for data ingestion

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── core/
│   ├── app_config.dart          # Application configuration
│   └── logger.dart              # Logging utilities
├── models/
│   ├── hr_packet.dart           # Heart rate data model
│   ├── imu_packet.dart          # IMU sensor data model
│   ├── sensor_device.dart       # Device representation
│   └── session_event.dart       # Session event tracking
├── providers/
│   ├── devices_provider.dart    # Device state management
│   ├── live_stream_provider.dart # Real-time data streaming
│   └── session_provider.dart    # Session state management
├── screens/
│   ├── home_screen.dart         # Main navigation screen
│   ├── device_scan_screen.dart  # BLE device discovery
│   ├── live_monitor_screen.dart # Real-time data dashboard
│   └── device_debug_screen.dart # Device debugging tools
├── services/
│   ├── ble/
│   │   ├── movesense_scanner.dart  # BLE scanning logic
│   │   ├── movesense_connect.dart  # Device connection handling
│   │   └── movesense_parse.dart    # Data parsing utilities
│   ├── ingest/
│   │   └── ingest_service.dart     # Data ingestion service
│   └── time/
│       └── timestamp_service.dart  # Timestamp synchronization
└── widgets/
    ├── sensor_tile.dart         # Sensor display component
    ├── status_banner.dart       # Connection status indicator
    └── live_chart.dart          # Real-time data chart
```

## Setup Instructions

### Prerequisites

- macOS (for iOS development)
- Flutter SDK (stable channel)
- Xcode with Command Line Tools
- CocoaPods
- Physical iOS device (BLE not supported on simulator)

### Installation

1. **Install Flutter**
   ```bash
   # Download from https://docs.flutter.dev/get-started/install
   # Add to PATH in ~/.zshrc
   export PATH="$PATH:$HOME/development/flutter/bin"
   ```

2. **Install Xcode**
   - Install from Mac App Store
   - Accept license: `sudo xcodebuild -license accept`
   - Select Command Line Tools in Xcode Preferences → Locations

3. **Install CocoaPods**
   ```bash
   brew install cocoapods
   ```

4. **Clone and Setup**
   ```bash
   git clone https://github.com/aajlani2025/GamePulse-Mobile.git
   cd GamePulse-Mobile
   flutter pub get
   cd ios && pod install && cd ..
   ```

5. **Verify Setup**
   ```bash
   flutter doctor -v
   ```

### Running the App

Connect a physical iOS device, then:
```bash
flutter run
```

## Usage

1. **Device Scanning**: Navigate to scan screen to discover Movesense sensors
2. **Connect Devices**: Tap on discovered devices to establish BLE connection
3. **Live Monitoring**: View real-time HR and IMU data on the monitor screen
4. **Session Management**: Start/stop data collection sessions
5. **Debug**: Use debug screen for device-level troubleshooting

## Data Formats

**Heart Rate Packet**:
```json
{
  "sensor_id": "174630000123",
  "session_id": "session_abc123",
  "timestamp": 1701234567890,
  "average": 75,
  "rrData": [812, 805, 798]
}
```

**IMU Packet**:
```json
{
  "sensor_id": "174630000123",
  "session_id": "session_abc123",
  "timestamp": 1701234567890,
  "acc": [[0.1, 0.2, 9.8], ...],
  "gyro": [[0.01, -0.02, 0.03], ...],
  "magn": [[25.1, -12.3, 45.6], ...]
}
```

## Author

**Hanine Khemir**

## License

This project is proprietary. All rights reserved.
