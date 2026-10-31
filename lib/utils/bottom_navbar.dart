import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';

class GradientBottomNavBarPageView extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const GradientBottomNavBarPageView({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.pureWhite,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEBF0F3),
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0C061C2B),
            blurRadius: 18,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Home
              _buildNavItem(
                index: 0,
                icon: LucideIcons.home,
                label: 'Home',
                isSelected: currentIndex == 0,
              ),

              // 2. Payments
              _buildNavItem(
                index: 1,
                icon: LucideIcons.creditCard,
                label: 'Payments',
                isSelected: currentIndex == 1,
              ),

              // 3. Center Elevated Scan Button
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabChanged(2),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Transform.translate(
                      offset: const Offset(0, -10),
                      child: Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.deepTeal, // #003D46
                          border: Border.all(
                            color: AppColors.electricMint.withOpacity(0.55),
                            width: 1.8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.deepTeal.withOpacity(0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                            BoxShadow(
                              color: AppColors.electricMint.withOpacity(0.22),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            LucideIcons.scan,
                            color: AppColors.electricMint,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // 4. Rewards
              _buildNavItem(
                index: 3,
                icon: LucideIcons.star,
                label: 'Rewards',
                isSelected: currentIndex == 3,
              ),

              // 5. Profile
              _buildNavItem(
                index: 4,
                icon: LucideIcons.user,
                label: 'Profile',
                isSelected: currentIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    final activeColor = AppColors.deepTeal; // #003D46
    final inactiveColor = AppColors.mutedSlate; // #687986

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTabChanged(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? activeColor : inactiveColor,
              size: 22,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
