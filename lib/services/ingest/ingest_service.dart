// lib/services/ingest/ingest_service.dart

import 'dart:convert';
import '../../models/hr_packet.dart';
import '../../models/imu_packet.dart';

class IngestService {
  // Mode TEST LOCAL - just print to console
  static void connectAll() {
    print('IngestService: TEST LOCAL mode active (no server)');
  }

  static void sendImu(ImuPacket data) {
    final json = data.toJson();
    print('IMU → ${jsonEncode(json).substring(0, 200)}...');
  }

  static void sendHr(HrPacket data) {
    final json = data.toJson();
    print('HR  → $json');
  }
}

// REAL WebSocket version (commented out for now):
// import 'dart:convert';
// import 'package:web_socket_channel/io.dart';
// import '../../core/app_config.dart';
// import '../../models/hr_packet.dart';
// import '../../models/imu_packet.dart';
//
// class IngestService {
//   static late IOWebSocketChannel _imuChannel;
//   static late IOWebSocketChannel _hrChannel;
//
//   static void connectAll() {
//     _connectImu();
//     _connectHr();
//   }
//
//   static void _connectImu() {
//     try {
//       _imuChannel = IOWebSocketChannel.connect(Uri.parse(AppConfig.wsImuUrl));
//     } catch (e) {
//       Future.delayed(const Duration(seconds: 3), _connectImu);
//     }
//   }
//
//   static void _connectHr() {
//     try {
//       _hrChannel = IOWebSocketChannel.connect(Uri.parse(AppConfig.wsHrUrl));
//     } catch (e) {
//       Future.delayed(const Duration(seconds: 3), _connectHr);
//     }
//   }
//
//   static void sendImu(ImuPacket data) {
//     try {
//       _imuChannel.sink.add(jsonEncode(data.toJson()));
//     } catch (_) {}
//   }
//
//   static void sendHr(HrPacket data) {
//     try {
//       _hrChannel.sink.add(jsonEncode(data.toJson()));
//     } catch (_) {}
//   }
// }
