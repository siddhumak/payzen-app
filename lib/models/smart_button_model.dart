import 'package:flutter/material.dart';

class SmartButtonCardModel {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final Color containerBg;
  final Color hoverBg;
  final Color borderColor;
  final Color hoverBorderColor;
  final String title;
  final String subtitle;

  SmartButtonCardModel({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.containerBg,
    required this.hoverBg,
    required this.borderColor,
    required this.hoverBorderColor,
    required this.title,
    required this.subtitle,
  });
}
