// lib/models/hr_packet.dart

class HrPacket {
  final String sensorId;
  final String sessionId;
  final int? gatewayTime;
  final Map<String, dynamic> rawData;
  final double average;

  HrPacket({
    required this.sensorId,
    required this.sessionId,
    this.gatewayTime,
    required this.rawData,
    this.average = 0.0,
  });

  factory HrPacket.fromRaw({
    required String sensorId,
    required String sessionId,
    required int gatewayTime,
    required Map<String, dynamic> body,
  }) {
    return HrPacket(
      sensorId: sensorId,
      sessionId: sessionId,
      gatewayTime: gatewayTime,
      rawData: body,
      average: (body['average'] as num?)?.toDouble() ?? 0.0,
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
