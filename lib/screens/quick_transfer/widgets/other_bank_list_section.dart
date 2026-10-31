import 'package:flutter/material.dart';

class OtherBankList extends StatelessWidget {
  final List<String> banks;
  final bool showViewAll;
  final Function(String bank) onBankSelected;

  const OtherBankList({
    super.key,
    required this.banks,
    this.showViewAll = false,
    required this.onBankSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🏦   All Other Banks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              for (var bank in banks)
                ListTile(
                  leading: const Icon(
                    Icons.account_balance,
                    color: Colors.blueAccent,
                  ),
                  title: Text(
                    bank,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => onBankSelected(bank),
                ),
              if (showViewAll)
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All Banks',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
