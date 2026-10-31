import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:m2online_recharge_app/components/build_lablel.dart';
import 'package:m2online_recharge_app/components/custom_text_field.dart';
import 'package:m2online_recharge_app/constant/colors.dart';
import 'package:m2online_recharge_app/screens/mycards/widgets/amount_input_card.dart';

class ToBankFormCard extends StatefulWidget {
  const ToBankFormCard({super.key});

  @override
  State<ToBankFormCard> createState() => _ToBankFormCardState();
}

class _ToBankFormCardState extends State<ToBankFormCard> {
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController ifscCode = TextEditingController();
  final TextEditingController amount = TextEditingController();

  bool showAccountNumber = false;
  String enterAmount = '';

  void setEnterAmount(String amount) {
    setState(() {
      enterAmount = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelWithIcon(
            icon: LucideIcons.building2,
            text: 'Bank Account Number',
            color: AppColors.primary,
          ),
          SizedBox(height: 10),
          CustomTextField2(
            controller: accountNumber,
            hint: 'Enter account number',
            isPassword: true,
            showPassword: showAccountNumber,
            togglePassword: () {
              setState(() => showAccountNumber = !showAccountNumber);
            },
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 20),
          LabelWithIcon(
            icon: LucideIcons.keyRound,
            text: 'IFSC Code',
            color: AppColors.primary,
          ),
          SizedBox(height: 10),
          CustomTextField2(
            controller: ifscCode,
            hint: 'Enter IFSC code (e.g., HDFC0001234)',
            textCapitalization: TextCapitalization.characters,
          ),

          const SizedBox(height: 20),
          LabelWithIcon(
            icon: LucideIcons.wallet,
            text: 'Amount To Send',
            color: AppColors.primary,
          ),
          SizedBox(height: 10),
          Stack(
            children: [
              // Amount Input
              AmountInputCard(
                amount: enterAmount,
                onAmountChanged: setEnterAmount,
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
