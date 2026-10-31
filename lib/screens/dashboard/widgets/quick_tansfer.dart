import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:m2online_recharge_app/constant/colors.dart';
import 'package:m2online_recharge_app/models/quick_transfer_model.dart';
import 'package:m2online_recharge_app/routes/app_routes.dart';

class QuickTansfer extends StatelessWidget {
  const QuickTansfer({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryActions = [
      TransferAction(
        icon: Icons.qr_code_scanner_outlined,
        label: 'Scan & Pay',
        gradient: [AppColors.primary, AppColors.primarydark],
        shadow: BoxShadow(color: AppColors.secondary),
        onTap: () => Get.toNamed('/scanner'),
      ),
      TransferAction(
        icon: LucideIcons.arrowUp,
        label: 'To Mobile',
        gradient: [AppColors.primary, AppColors.primarydark],
        shadow: BoxShadow(color: AppColors.secondary),
        onTap: () => Get.offNamed(AppRoutes.toMobile),
      ),
      TransferAction(
        icon: LucideIcons.building2,
        label: 'To Bank A/c',
        gradient: [AppColors.primary, AppColors.primarydark],
        shadow: BoxShadow(color: AppColors.secondary),
        onTap: () => Get.offNamed(AppRoutes.toBank),
      ),
      TransferAction(
        icon: LucideIcons.refreshCw,
        label: 'To Self A/c',
        gradient: [AppColors.primary, AppColors.primarydark],
        shadow: BoxShadow(color: AppColors.secondary),
        onTap: () => Get.offNamed(AppRoutes.addbank),
      ),
    ];

    final secondaryActions = [
      TransferAction(
        icon: LucideIcons.fileText,
        label: 'Balance & History',
        borderColor: AppColors.primary,
        onTap: () => Get.offNamed('/wallet'),
      ),
      TransferAction(
        icon: LucideIcons.users,
        label: 'Refer & Earn',
        borderColor: AppColors.primary,
        onTap: () => Get.offNamed(AppRoutes.referEarn),
      ),
      TransferAction(
        icon: Icons.qr_code_2_outlined,
        label: 'Receive Money',
        borderColor: AppColors.primary,
        onTap: () => Get.offNamed(AppRoutes.qr),
      ),
      TransferAction(
        icon: LucideIcons.zap,
        label: "What's New",
        borderColor: AppColors.primary,
        badge: true,
        onTap: () => Get.toNamed('/whatsNew'),
      ),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondary.withOpacity(0.1), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Transfer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 20),

            // Primary Actions Grid
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
              children:
                  primaryActions.map((action) {
                    return GestureDetector(
                      onTap: action.onTap,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: action.gradient!,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [action.shadow!],
                            ),
                            child: Icon(
                              action.icon,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            action.label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF1E1E1E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),

            const SizedBox(height: 24),

            // Secondary Actions Grid
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.7,
              children:
                  secondaryActions.map((action) {
                    return GestureDetector(
                      onTap: action.onTap,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color:
                                        action.borderColor ?? AppColors.primary,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  action.icon,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                              ),
                              if (action.badge == true)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFFC107),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: CircleAvatar(
                                        radius: 4,
                                        backgroundColor: Color(0xFF1E1E1E),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            action.label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF1E1E1E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
