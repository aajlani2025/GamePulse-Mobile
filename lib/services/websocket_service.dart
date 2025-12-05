// import 'dart:convert';
// import 'package:web_socket_channel/io.dart';
// import '../models/sensor_data.dart';

// class WebSocketService {
//   static final WebSocketService i = WebSocketService._();
//   WebSocketService._();

//   // CHANGE ICI TES DEUX URLs
//   static const String _imuUrl = "ws://192.168.1.50:3000/imu";
//   static const String _hrUrl  = "ws://192.168.1.50:3000/hr";

//   late IOWebSocketChannel _imuChannel;
//   late IOWebSocketChannel _hrChannel;

//   void connectAll() {
//     _connectImu();
//     _connectHr();
//   }

//   void _connectImu() {
//     try {
//       _imuChannel = IOWebSocketChannel.connect(Uri.parse(_imuUrl));
//     } catch (e) {
//       Future.delayed(const Duration(seconds: 3), _connectImu);
//     }
//   }

//   void _connectHr() {
//     try {
//       _hrChannel = IOWebSocketChannel.connect(Uri.parse(_hrUrl));
//     } catch (e) {
//       Future.delayed(const Duration(seconds: 3), _connectHr);
//     }
//   }

//   void sendImu(SensorData data) {
//     try {
//       _imuChannel.sink.add(jsonEncode(data.toJson()));
//     } catch (_) {}
//   }

//   void sendHr(SensorData data) {
//     try {
//       _hrChannel.sink.add(jsonEncode(data.toJson()));
//     } catch (_) {}
//   }
// }

// lib/core/services/websocket_service.dart   ← VERSION TEST LOCAL UNIQUEMENT

import 'dart:convert';
import '../models/sensor_data.dart';

class WebSocketService {
  static final WebSocketService i = WebSocketService._();
  WebSocketService._();

  // On ne connecte RIEN → on affiche juste dans la console
  void connectAll() {
    print("WebSocketService : mode TEST LOCAL activé (pas de serveur)");
  }

  void sendImu(SensorData data) {
    final json = data.toJson();
    print("IMU → ${jsonEncode(json).substring(0, 200)}...");
  }

  void sendHr(SensorData data) {
    final json = data.toJson();
    print("HR  → $json");
  }
}