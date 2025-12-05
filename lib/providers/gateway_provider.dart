import 'package:flutter/foundation.dart';
import '../services/movesense_service.dart';

class GatewayProvider extends ChangeNotifier {
  Map<String, String> get sensors => MovesenseService.players ;

  void start() {
    MovesenseService.start();
    notifyListeners();
  }

  void stop() {
    MovesenseService.stop();
    notifyListeners();
  }
}