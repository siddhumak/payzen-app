import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:m2online_recharge_app/constant/colors.dart';
import 'package:m2online_recharge_app/screens/mycards/widgets/amount_input_card.dart';

class DepositWidget extends StatefulWidget {
  final void Function(String amount)? onSubmit;

  const DepositWidget({super.key, this.onSubmit});

  @override
  State<DepositWidget> createState() => _DepositWidgetState();
}

class _DepositWidgetState extends State<DepositWidget> {
  String depositAmount = '';

  String selectedPaymentMethod = 'UPI'; // or set a default

  void setDepositAmount(String amount) {
    setState(() {
      depositAmount = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Amount Input
            AmountInputCard(
              title: "Deposit Money",
              subtitle: "Add money to your selected card",
              icon: LucideIcons.download,
              iconColor: Colors.red,
              amount: depositAmount,
              onAmountChanged: setDepositAmount,
            ),

            const SizedBox(height: 24),

            // Payment Methods
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment Method",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                _paymentMethodTile(
                  imagePath: 'assets/images/upi.png',
                  title: "UPI",
                  subtitle: "Pay using UPI apps",
                ),
                const SizedBox(height: 12),
                _paymentMethodTile(
                  imagePath: 'assets/images/bank.png',
                  title: "Bank Transfer",
                  subtitle: "Transfer from bank account",
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Inside your StatefulWidget:

  Widget _paymentMethodTile({
    required String imagePath, // Add imagePath instead of icon
    required String title,
    required String subtitle,
  }) {
    final isSelected = selectedPaymentMethod == title;

    return InkWell(
      onTap: () {
        setState(() {
          selectedPaymentMethod = title;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? AppColors.primary.withOpacity(0.05) : null,
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 28,
              height: 28,
              //color: isSelected ? AppColors.primary : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppColors.primary : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          isSelected
                              ? AppColors.primary.withOpacity(0.8)
                              : Colors.grey,
                    ),
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
