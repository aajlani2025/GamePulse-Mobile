// lib/screens/live_monitor_screen.dart

import 'package:flutter/material.dart';

class LiveMonitorScreen extends StatelessWidget {
  const LiveMonitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Monitor'),
        backgroundColor: Colors.purple,
      ),
      body: const Center(
        child: Text('Live monitor - to implement'),
      ),
    );
  }
}
