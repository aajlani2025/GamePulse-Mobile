import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/gateway_provider.dart';
import 'screens/gateway_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GatewayProvider(),
      child: const MaterialApp(home: GatewayScreen()),
    ),
  );
}