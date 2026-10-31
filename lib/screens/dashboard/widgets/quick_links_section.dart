import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/models/smart_button_model.dart';

class QuickLinksSection extends StatelessWidget {
  const QuickLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SmartButtonCardModel> quickLinkItems = [
      SmartButtonCardModel(
        icon: LucideIcons.sparkles,
        iconColor: Colors.white,
        iconBgColor: AppColors.primarydark,
        containerBg: Colors.white,
        hoverBg: Colors.grey,
        borderColor: AppColors.primarydark,
        hoverBorderColor: AppColors.primary,
        title: 'Activate Cashback Offers',
        subtitle: 'Get up to 10% back',
      ),
      SmartButtonCardModel(
        icon: LucideIcons.creditCard,
        iconColor: Colors.white,
        iconBgColor: AppColors.primarydark,
        containerBg: Colors.white,
        hoverBg: Colors.grey,
        borderColor: AppColors.primarydark,
        hoverBorderColor: AppColors.primary,
        title: 'Link / Change Bank Account',
        subtitle: 'Manage your banks',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          for (final item in quickLinkItems) ...[
            _SmartButtonCard(model: item),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _SmartButtonCard extends StatelessWidget {
  final SmartButtonCardModel model;

  const _SmartButtonCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {}, // Replace with real action
      splashColor: Colors.transparent,
      highlightColor: model.hoverBg.withOpacity(0.3),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: model.containerBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: model.borderColor),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: model.iconBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(model.icon, size: 16, color: model.iconColor),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    model.subtitle,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
