import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const LabelWithIcon({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
