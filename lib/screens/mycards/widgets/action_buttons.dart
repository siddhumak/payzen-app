// screens/mycards/widgets/action_buttons_row.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:m2online_recharge_app/constant/colors.dart';

class ActionButtonsRow extends StatelessWidget {
  final VoidCallback onDepositTap;
  final VoidCallback onWithdrawTap;

  const ActionButtonsRow({
    super.key,
    required this.onDepositTap,
    required this.onWithdrawTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onDepositTap,
              icon: const Icon(LucideIcons.download, size: 20),
              label: const Text('Deposit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 6,
                shadowColor: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onWithdrawTap,
              icon: const Icon(LucideIcons.upload, size: 20),
              label: const Text('Withdraw'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                side: const BorderSide(width: 2, color: Colors.grey),
                foregroundColor: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
