class SensorData {
  final String sensorId;
  final String sessionId;
  final int? gatewayTime;     // null = utilise data.Timestamp pour IMU
  final Map<String, dynamic> rawData;

  SensorData({
    required this.sensorId,
    required this.sessionId,
    this.gatewayTime,
    required this.rawData,
  });
  
  Map<String, dynamic> toJson() {
    final map = {
      "sensor_id": sensorId,
      "session_id": sessionId,
      "data": rawData,
    };
    if (gatewayTime != null) {
      map["gateway_time"] = gatewayTime!;
    }
    return map;
  }
}