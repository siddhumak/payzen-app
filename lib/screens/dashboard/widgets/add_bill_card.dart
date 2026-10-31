import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:m2online_recharge_app/constant/colors.dart';

class AddBillCard extends StatelessWidget {
  final VoidCallback? onTap;
  const AddBillCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.plus, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "Add New or View existing Bills",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
          const Icon(LucideIcons.shieldCheck, size: 16, color: Colors.green),
          const SizedBox(width: 4),
          const Text(
            "No extra charges",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
