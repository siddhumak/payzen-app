import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TransactionItem extends StatelessWidget {
  final IconData icon;
  final String merchant;
  final String time;
  final String card;
  final String amount;
  final bool isCredit;
  final bool showBalance;

  const TransactionItem({
    super.key,
    required this.icon,
    required this.merchant,
    required this.time,
    required this.card,
    required this.amount,
    required this.isCredit,
    required this.showBalance,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Navigate or show transaction details
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Icon(icon, size: 24, color: Colors.grey[800]),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    merchant,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$time • $card",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                Text(
                  showBalance ? amount : "₹•••",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isCredit ? Colors.green[700] : Colors.red[600],
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  LucideIcons.chevronRight,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
