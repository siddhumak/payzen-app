import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:m2online_recharge_app/screens/mycards/widgets/transaction_items.dart';


class Transaction {
  final int id;
  final IconData icon;
  final String merchant;
  final String time;
  final String card;
  final String amount;
  final bool isCredit;

  Transaction({
    required this.id,
    required this.icon,
    required this.merchant,
    required this.time,
    required this.card,
    required this.amount,
    required this.isCredit,
  });

  // Factory to derive isCredit from 'type'
  factory Transaction.fromType({
    required int id,
    required IconData icon,
    required String merchant,
    required String time,
    required String card,
    required String amount,
    required String type,
  }) {
    return Transaction(
      id: id,
      icon: icon,
      merchant: merchant,
      time: time,
      card: card,
      amount: amount,
      isCredit: type.toLowerCase() == 'credit',
    );
  }
}

class TransactionSection extends StatelessWidget {
  final List<Transaction> transactions;
  final bool showBalance;
  final VoidCallback onToggleBalance;

  const TransactionSection({
    super.key,
    required this.transactions,
    required this.showBalance,
    required this.onToggleBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Transactions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onToggleBalance,
                  icon: Icon(
                    showBalance ? LucideIcons.eye : LucideIcons.eyeOff,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                  splashRadius: 20,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              children:
                  transactions.map((txn) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TransactionItem(
                        icon: txn.icon,
                        merchant: txn.merchant,
                        time: txn.time,
                        card: txn.card,
                        amount: txn.amount,
                        isCredit: txn.isCredit,
                        showBalance: showBalance,
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
