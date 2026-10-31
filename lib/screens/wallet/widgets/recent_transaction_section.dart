// lib/screens/wallet/widgets/recent_transactions_section.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:m2online_recharge_app/constant/colors.dart';

class RecentTransactionsSection extends StatelessWidget {
  final List<Map<String, dynamic>> recentTransactions;

  const RecentTransactionsSection({
    super.key,
    required this.recentTransactions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    LucideIcons.history,
                    color: AppColors.primarydark,
                    size: 18,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // Navigate to full transaction history
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.primarydark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 4),
        Column(
          children:
              recentTransactions.map((tx) {
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFF8B0000),
                      child: Text(
                        tx['icon'] as String,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    title: Text(
                      tx['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      '${tx['time']} • ${tx['type']}',
                      style: const TextStyle(color: Colors.black26),
                    ),
                    trailing: Text(
                      tx['amount'] as String,
                      style: TextStyle(
                        color:
                            tx['positive'] as bool
                                ? Colors.green
                                : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
