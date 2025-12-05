// lib/core/services/movesense_service.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mdsflutter/Mds.dart';
import '../models/sensor_data.dart';
import 'websocket_service.dart';

class MovesenseService {
  static final String sessionId = DateTime.now()
      .toUtc()
      .toIso8601String()
      .substring(0, 19) + "Z";

  // Reset à chaque nouvelle tentative de connexion → sync renvoyé si reconnect
  static final Set<String> _imuSyncSentThisConnection = {};

  // Map of connected devices (serial -> player name)
  static final Map<String, String> players = {};

  // Simple logging via print
  static void _log(String message, {Color? color}) {
    print("[MovesenseService] $message");
  }

  static void start() {
    _log("GATEWAY DÉMARRÉ – SCAN BLE EN COURS", color: Colors.cyan);
    WebSocketService.i.connectAll();

    Mds.startScan((name, serial) {
      if (serial == null) return;
      final short = serial.substring(serial.length - 8);

      // Add to players map
      if (!players.containsKey(serial)) {
        players[serial] = "P${players.length + 1}";
      }

      _log("CAPTEUR DÉTECTÉ → $name | $short", color: Colors.cyan);
      _connect(serial);
    });
  }

  static void stop() {
    _log("ARRÊT DU GATEWAY – arrêt scan + déconnexion de tous les capteurs", color: Colors.red);

    // Arrête le scan
    Mds.stopScan();

    // Déconnecte TOUS les capteurs connectés
    for (final serial in players.keys.toList()) {
      _log("DÉCONNEXION FORCÉE → ${serial.substring(serial.length - 8)}", color: Colors.orange);
      Mds.disconnect(serial);
    }

    // Nettoie les flags de sync (au cas où on redémarre plus tard)
    _imuSyncSentThisConnection.clear();
  }

  static void _connect(String serial) {
    final short = serial.substring(serial.length - 8);

    _imuSyncSentThisConnection.remove(serial); // ← reset à chaque reconnexion
    _log("TENTATIVE CONNEXION → $short", color: Colors.yellow);

    Mds.connect(
      serial,
      (_) {
        _log("CONNECTÉ → $short", color: Colors.green);
        _subscribeAll(serial);
      },
      () {
        _log("DÉCONNECTÉ → RETRY DANS 3s", color: Colors.red);
        Future.delayed(const Duration(seconds: 3), () => _connect(serial));
      },
      (error) {
        _log("ERREUR CONNEXION → $short | $error", color: Colors.red);
        Future.delayed(const Duration(seconds: 3), () => _connect(serial));
      },
      (_) {},
    );
  }

  static void _subscribeAll(String serial) {
    final short = serial.substring(serial.length - 8);

    // FLUX HR — 100 % brut
    Mds.subscribe(
      Mds.createSubscriptionUri(serial, '/Meas/HR'),
      '{}',
      (_, __) { _log("ABONNEMENT HR OK → $short", color: Colors.yellow); },
      (_, error) { _log("ERREUR ABONNEMENT HR → $error", color: Colors.red); },
      (notification) {
        try {
          final decoded = jsonDecode(notification) as Map<String, dynamic>;
          final body = decoded['Body'];
          _log("HR REÇU → $short", color: Colors.purple);
          WebSocketService.i.sendHr(SensorData(
            sensorId: serial,
            sessionId: sessionId,
            gatewayTime: DateTime.now().millisecondsSinceEpoch,
            rawData: body,
          ));
        } catch (e) {
          _log("ERREUR DÉCODAGE HR → $e", color: Colors.red);
        }
      },
      (_, error) { _log("ERREUR SOUSCRIPTION HR → $error", color: Colors.red); },
    );

    // FLUX IMU — sync = premier paquet complet (body brut)
    Mds.subscribe(
      Mds.createSubscriptionUri(serial, '/Meas/IMU9/104'),
      '{}',
      (_, __) { _log("ABONNEMENT IMU OK → $short", color: Colors.yellow); },
      (_, error) { _log("ERREUR ABONNEMENT IMU → $error", color: Colors.red); },
      (notification) {
        try {
          final decoded = jsonDecode(notification) as Map<String, dynamic>;
          final body = decoded['Body'];
          final now = DateTime.now().millisecondsSinceEpoch;

          // PREMIER PAQUET → envoie tout le body brut comme sync
          if (!_imuSyncSentThisConnection.contains(serial)) {
            _imuSyncSentThisConnection.add(serial);
            _log("SYNC IMU ENVOYÉ (premier paquet complet) → $short", color: Colors.orange);

            WebSocketService.i.sendImu(SensorData(
              sensorId: serial,
              sessionId: sessionId,
              gatewayTime: now,
              rawData: body, // ← EXACTEMENT CE QUE TU VEUX : tout le body brut
            ));
          }

          // Tous les paquets (y compris le premier) → envoyés normalement
          _log("IMU REÇU → $short | ts=${body['Timestamp']}", color: Colors.blue);
          WebSocketService.i.sendImu(SensorData(
            sensorId: serial,
            sessionId: sessionId,
            rawData: body,
          ));
        } catch (e) {
          _log("ERREUR DÉCODAGE IMU → $e", color: Colors.red);
        }
      },
      (_, error) { _log("ERREUR SOUSCRIPTION IMU → $error", color: Colors.red); },
    );
  }
}