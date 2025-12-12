// lib/widgets/status_banner.dart

import 'package:flutter/material.dart';

class StatusBanner extends StatelessWidget {
  final bool isActive;
  final int deviceCount;

  const StatusBanner({
    super.key,
    required this.isActive,
    required this.deviceCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: isActive ? Colors.green : Colors.grey,
      child: Text(
        isActive ? 'Active - $deviceCount devices' : 'Idle',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
