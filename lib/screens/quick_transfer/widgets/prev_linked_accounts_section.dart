// File: components/previously_linked_accounts.dart

import 'package:flutter/material.dart';
import 'package:payzen_app/constant/colors.dart';

class PreviouslyLinkedAccounts extends StatelessWidget {
  final List<Map<String, String>> accounts;

  const PreviouslyLinkedAccounts({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🏛️   Previously Linked Accounts',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        ...accounts.map(
          (account) => Card(
            color: AppColors.primary,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.check, color: Colors.black),
              ),
              title: Text(account['bank'] ?? ''),
              subtitle: Text(
                '${account['accountNumber']} • ${account['upiId']}',
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
