// lib/utils/bottom_navbar_pageview.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/app_gradients.dart';
import 'package:payzen_app/constant/colors.dart';

class GradientBottomNavBarPageView extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const GradientBottomNavBarPageView({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
  });

  static final _items = [
    _BottomItem('Home', Icons.home),
    _BottomItem('Wallet', Icons.account_balance_wallet),
    _BottomItem('Scan', LucideIcons.qrCode),
    _BottomItem('Cards', LucideIcons.creditCard),
    _BottomItem('More', LucideIcons.moreVertical),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          final selected = i == currentIndex;

          if (i == 2) {
            // Special Scan Button
            return Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(i),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppGradients.gradient1,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: const Icon(
                        LucideIcons.qrCode,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Scan',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Regular bottom nav items
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTabChanged(i),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  selected
                      ? Container(
                        height: 40,
                        width: 48,
                        decoration: BoxDecoration(
                          gradient: AppGradients.gradient1,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          _items[i].icon,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                      : Icon(_items[i].icon, color: Colors.black54, size: 24),
                  const SizedBox(height: 4),
                  Text(
                    _items[i].label,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: selected ? Colors.black : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ✅ Move this OUTSIDE the class
class _BottomItem {
  final String label;
  final IconData icon;
  const _BottomItem(this.label, this.icon);
}
