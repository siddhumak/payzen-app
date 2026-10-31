// File: widgets/plan_card.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/app_gradients.dart';
import 'package:payzen_app/constant/colors.dart';

class PlanCard extends StatelessWidget {
  final Map<String, dynamic> plan;
  final VoidCallback onTap;

  const PlanCard({super.key, required this.plan, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primarydark, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (plan['popular'])
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  gradient: AppGradients.gradient3,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "MOST POPULAR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan['price'],
                      style: GoogleFonts.inter(
                        color: AppColors.primarydark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Validity: ${plan['validity']}",
                      style: GoogleFonts.inter(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.black12, width: 1),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.chevron_right,
                    color: AppColors.primarydark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(LucideIcons.wifi, color: Colors.lightBlue, size: 16),
                const SizedBox(width: 8),
                Text(
                  "${plan['data']} Data",
                  style: GoogleFonts.inter(color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 2),
            Row(
              children: [
                const Icon(LucideIcons.phone, color: Colors.green, size: 16),
                const SizedBox(width: 8),
                Text(
                  "${plan['calls']} Calls",
                  style: GoogleFonts.inter(color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 2),
            Row(
              children: [
                const Icon(LucideIcons.clock, color: Colors.orange, size: 16),
                const SizedBox(width: 8),
                Text(
                  "${plan['sms']} SMS",
                  style: GoogleFonts.inter(color: Colors.black54),
                ),
              ],
            ),
            if ((plan['benefits'] as List).isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text(
                "Benefits:",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Wrap(
                spacing: 8,
                children:
                    (plan['benefits'] as List)
                        .map(
                          (benefit) => Chip(
                            backgroundColor: Colors.white12,
                            label: Text(
                              benefit,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
