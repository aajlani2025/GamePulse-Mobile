// lib/widgets/sensor_tile.dart

import 'package:flutter/material.dart';
import '../models/sensor_device.dart';

class SensorTile extends StatelessWidget {
  final SensorDevice device;
  final VoidCallback? onTap;

  const SensorTile({super.key, required this.device, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        device.isConnected ? Icons.bluetooth_connected : Icons.bluetooth,
        color: device.isConnected ? Colors.green : Colors.grey,
      ),
      title: Text(device.name),
      subtitle: Text(device.shortId),
      onTap: onTap,
    );
  }
}
