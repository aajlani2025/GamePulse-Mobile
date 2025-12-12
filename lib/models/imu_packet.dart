// lib/models/imu_packet.dart

class ImuPacket {
  final String sensorId;
  final String sessionId;
  final int? gatewayTime;
  final Map<String, dynamic> rawData;
  final int timestamp;

  ImuPacket({
    required this.sensorId,
    required this.sessionId,
    this.gatewayTime,
    required this.rawData,
    this.timestamp = 0,
  });

  factory ImuPacket.fromRaw({
    required String sensorId,
    required String sessionId,
    int? gatewayTime,
    required Map<String, dynamic> body,
  }) {
    return ImuPacket(
      sensorId: sensorId,
      sessionId: sessionId,
      gatewayTime: gatewayTime,
      rawData: body,
      timestamp: body['Timestamp'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'sensor_id': sensorId,
      'session_id': sessionId,
      'data': rawData,
    };
    if (gatewayTime != null) {
      map['gateway_time'] = gatewayTime;
    }
    return map;
  }
}
