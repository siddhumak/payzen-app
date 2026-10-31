import 'package:flutter/material.dart';
import 'package:m2online_recharge_app/constant/colors.dart';
import 'package:m2online_recharge_app/screens/mycards/widgets/amount_selector_widget.dart';

class AmountInputCard extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final String amount;
  final ValueChanged<String> onAmountChanged;
  final List<String> quickAmounts;
  final Widget? topSection; // <- optional balance section

  const AmountInputCard({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    required this.amount,
    required this.onAmountChanged,
    this.quickAmounts = const ['1000', '2000', '5000'],
    this.topSection,
  });

  @override
  State<AmountInputCard> createState() => _AmountInputCardState();
}

class _AmountInputCardState extends State<AmountInputCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.amount);
  }

  @override
  void didUpdateWidget(covariant AmountInputCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.amount != widget.amount) {
      _controller.text = widget.amount;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon (only if icon is provided)
        if (widget.icon != null)
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color:
                  widget.iconColor?.withOpacity(0.1) ??
                  Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              widget.icon,
              color: widget.iconColor ?? Colors.grey,
              size: 32,
            ),
          ),

        if (widget.icon != null) const SizedBox(height: 16),

        // Title
        if (widget.title != null)
          Text(
            widget.title!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

        if (widget.title != null) const SizedBox(height: 6),

        // Subtitle
        if (widget.subtitle != null)
          Text(
            widget.subtitle!,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),

        const SizedBox(height: 24),

        // Top Section if provided
        if (widget.topSection != null) ...[
          widget.topSection!,
          const SizedBox(height: 24),
        ],

        // Amount Label
        const Align(
          alignment: Alignment.center,
          child: Text(
            "Enter Amount",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 6),

        // Amount Input with ₹ symbol
        Stack(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              onChanged: widget.onAmountChanged,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.5),
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                hintText: "0",
              ),
            ),
            const Positioned(
              left: 16,
              top: 18,
              child: Text(
                '₹',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Quick Amount Buttons
        QuickAmountSelector(
          amounts: widget.quickAmounts,
          selectedAmount: widget.amount,
          onAmountSelected: widget.onAmountChanged,
        ),
      ],
    );
  }
}
