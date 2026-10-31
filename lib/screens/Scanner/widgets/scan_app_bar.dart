// lib/screens/Scanner/widgets/scan_appbar.dart
import 'package:flutter/material.dart';

class ScanAppBar extends StatelessWidget {
  const ScanAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Scan QR to Pay",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 40), // Placeholder for symmetry
          ],
        ),
      ),
    );
  }
}
