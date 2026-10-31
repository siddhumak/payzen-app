import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget profileOptionTile({
  required Color backgroundColor,
  required IconData icon,
  required Color iconColor,
  required String title,
  VoidCallback? onTap,
}) {
  return ListTile(
    onTap: onTap,
    leading: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: iconColor),
      ),
    ),
    title: Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
  );
}
