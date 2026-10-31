// models/recharge_service_model.dart
import 'package:flutter/material.dart';

class RechargeServiceModel {
  final IconData icon;
  final String label;
  final String? badge;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final VoidCallback onTap;

  RechargeServiceModel({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge,
    this.badgeColor,
    this.badgeTextColor,
  });
}
