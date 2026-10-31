import 'package:flutter/material.dart';
import 'package:payzen_app/constant/colors.dart';

class QuickAmountSelector extends StatelessWidget {
  final List<String> amounts;
  final String selectedAmount;
  final void Function(String) onAmountSelected;

  const QuickAmountSelector({
    super.key,
    required this.amounts,
    required this.selectedAmount,
    required this.onAmountSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          amounts.map((amount) {
            final isSelected = selectedAmount == amount;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: OutlinedButton(
                  onPressed: () => onAmountSelected(amount),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      width: 2,
                      color: isSelected ? AppColors.primary : Colors.grey,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    foregroundColor: Colors.black,
                    backgroundColor:
                        isSelected ? Colors.red.withOpacity(0.1) : null,
                  ),
                  child: Text('₹$amount'),
                ),
              ),
            );
          }).toList(),
    );
  }
}
