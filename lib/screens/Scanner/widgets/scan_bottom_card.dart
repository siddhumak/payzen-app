import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ScanBottomCard extends StatelessWidget {
  const ScanBottomCard({super.key});

  @override
  Widget build(BuildContext context) {
    final recentContacts = [
      {'name': 'Rahul', 'initial': 'R'},
      {'name': 'Priya', 'initial': 'P'},
      {'name': 'Amit', 'initial': 'A'},
      {'name': 'Sarah', 'initial': 'S'},
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [BoxShadow(blurRadius: 24, color: Colors.black26)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Manual entry button
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(LucideIcons.smartphone, size: 20),
            label: const Text("Enter UPI ID or Mobile Number"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              elevation: 4,
            ),
          ),
          const SizedBox(height: 16),

          // Flash & My QR
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _actionButton(icon: LucideIcons.flashlight, label: "Flash"),
              const SizedBox(width: 12),
              _actionButton(icon: LucideIcons.qrCode, label: "My QR"),
            ],
          ),
          const SizedBox(height: 24),

          // Recent Contacts
          Column(
            children: [
              const Text(
                "Pay recent contacts",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    recentContacts.map((c) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFE53935),
                                    Color(0xFFD32F2F),
                                  ],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                c['initial']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              c['name']!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton({required IconData icon, required String label}) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16, color: Colors.black),
      label: Text(
        label,
        style: const TextStyle(fontSize: 13, color: Colors.black),
      ),
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        side: const BorderSide(color: Colors.grey),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
    );
  }
}
