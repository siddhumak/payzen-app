import 'package:flutter/material.dart';

class TransferAction {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final List<Color>? gradient;
  final BoxShadow? shadow;
  final Color? borderColor;
  final bool? badge;

  TransferAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.gradient,
    this.shadow,
    this.borderColor,
    this.badge = false,
  });
}
