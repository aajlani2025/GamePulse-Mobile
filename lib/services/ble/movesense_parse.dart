// lib/services/ble/movesense_parse.dart

class MovesenseParse {
  static double? extractHr(Map<String, dynamic> body) {
    return (body['average'] as num?)?.toDouble();
  }

  static int? extractTimestamp(Map<String, dynamic> body) {
    return body['Timestamp'] as int?;
  }
}
