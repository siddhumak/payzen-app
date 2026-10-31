import 'dart:ui';
import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CustomButton2({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.8),
            foregroundColor: Colors.black87,
            shadowColor: Colors.transparent,
            elevation: 0,
            side: BorderSide(color: Colors.blue.withOpacity(0.2)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size.fromHeight(48),
          ),
          icon: Icon(icon, size: 18),
          label: Text(label),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
