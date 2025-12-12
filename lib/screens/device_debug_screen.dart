// lib/screens/device_debug_screen.dart

import 'package:flutter/material.dart';

class DeviceDebugScreen extends StatelessWidget {
  const DeviceDebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text('Debug screen - to implement'),
      ),
    );
  }
}
