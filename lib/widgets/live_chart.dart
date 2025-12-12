// lib/widgets/live_chart.dart

import 'package:flutter/material.dart';

class LiveChart extends StatelessWidget {
  final List<double> data;

  const LiveChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('No data'));
    }
    return const Center(child: Text('Chart - to implement'));
  }
}
