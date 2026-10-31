// lib/screens/Scanner/widgets/scanning_box.dart
import 'package:flutter/material.dart';
import 'package:m2online_recharge_app/screens/Scanner/widgets/animated_scanning_line.dart';
import 'package:m2online_recharge_app/screens/Scanner/widgets/corner_painter.dart';

class ScanningBox extends StatelessWidget {
  const ScanningBox({super.key});

  Widget _cornerIndicator(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CustomPaint(painter: CornerPainter(alignment)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white60, width: 2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          _cornerIndicator(Alignment.topLeft),
          _cornerIndicator(Alignment.topRight),
          _cornerIndicator(Alignment.bottomLeft),
          _cornerIndicator(Alignment.bottomRight),
          const AnimatedScanLine(),
        ],
      ),
    );
  }
}
