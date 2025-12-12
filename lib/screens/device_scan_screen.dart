// lib/screens/device_scan_screen.dart

import 'package:flutter/material.dart';

class DeviceScanScreen extends StatelessWidget {
  const DeviceScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Devices'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text('Scan screen - to implement'),
      ),
    );
  }
}
