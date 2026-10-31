import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/screens/dashboard/widgets/add_bill_card.dart';
import 'package:payzen_app/models/recharge_service_model.dart'; // <-- import your model

class RechargeServicesSection extends StatelessWidget {
  const RechargeServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RechargeServiceModel> services = [
      RechargeServiceModel(
        icon: LucideIcons.smartphone,
        label: "Mobile Recharge",
        badge: "Zero Fee",
        badgeColor: AppColors.primary,
        badgeTextColor: Colors.white,
        onTap: () {
          Get.offNamed('/mobileRecharge');
        },
      ),
      RechargeServiceModel(
        icon: LucideIcons.zap,
        label: "Electricity Bill",
        onTap: () {
          Get.offNamed('/billList');
        },
      ),
      RechargeServiceModel(
        icon: LucideIcons.creditCard,
        label: "Credit Card Bill",
        onTap: () {},
      ),
      RechargeServiceModel(
        icon: LucideIcons.droplets,
        label: "Water Bill",
        onTap: () {},
      ),
    ];

    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFFF5F7)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recharges & Bills",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Row(
                  children: const [
                    Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      LucideIcons.chevronRight,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Services Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children:
                  services
                      .map((service) => RechargeServiceTile(service: service))
                      .toList(),
            ),

            const SizedBox(height: 24),

            // Add Bills Button
            AddBillCard(onTap: () {}),
          ],
        ),
      ),
    );
  }
}

// RechargeServiceTile widget
class RechargeServiceTile extends StatelessWidget {
  final RechargeServiceModel service;

  const RechargeServiceTile({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: service.onTap,
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primarydark),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(service.icon, size: 20, color: AppColors.primary),
                ),
                if (service.badge != null)
                  Positioned(
                    top: -8,
                    right: -8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: service.badgeColor ?? Colors.orange,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Text(
                        service.badge!,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: service.badgeTextColor ?? Colors.black,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Flexible(
              child: Text(
                service.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
