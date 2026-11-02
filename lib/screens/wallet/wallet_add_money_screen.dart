import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';

class WalletAddMoneyScreen extends StatefulWidget {
  const WalletAddMoneyScreen({super.key});

  @override
  State<WalletAddMoneyScreen> createState() => _WalletAddMoneyScreenState();
}

class _WalletAddMoneyScreenState extends State<WalletAddMoneyScreen> {
  final _amountController = TextEditingController(text: '1,000');
  final _amountFocusNode = FocusNode();
  int _selectedAmount = 1000;
  int _selectedMethod = 0;
  bool _typingPulse = false;
  Timer? _typingTimer;

  void _onAmountChanged(String value) {
    setState(() {
      _selectedAmount = int.tryParse(value.replaceAll(',', '')) ?? 0;
    });
    _pulseAmountField();
  }

  void _pulseAmountField() {
    _typingTimer?.cancel();
    setState(() => _typingPulse = true);
    _typingTimer = Timer(const Duration(milliseconds: 220), () {
      if (mounted) setState(() => _typingPulse = false);
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _amountFocusNode.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _selectAmount(int amount) {
    setState(() {
      _selectedAmount = amount;
      _amountController.text = _formatAmount(amount);
    });
    _pulseAmountField();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = (size.width / 390).clamp(0.88, 1.12).toDouble();
    final compact = size.height < 820;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.warmIvory,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF012C37), Color(0xFF004959)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/header_waves_bg.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomRight,
                  opacity: 0.72,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: SizedBox(
                  height: 108 * scale,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: Get.back,
                        icon: const Icon(
                          LucideIcons.arrowLeft,
                          color: Colors.white,
                          size: 25,
                        ),
                        tooltip: 'Back',
                      ),
                      SizedBox(width: 8 * scale),
                      Text(
                        'Add Money',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 22 * scale,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Transform.translate(
                offset: Offset(0, -24 * scale),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.warmIvory,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(38),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      20 * scale,
                      compact ? 12 : 18,
                      20 * scale,
                      16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned(
                                bottom: 2 * scale,
                                child: Container(
                                  width: 92 * scale,
                                  height: 6 * scale,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.deepTeal.withValues(
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 12 * scale,
                                        spreadRadius: 1 * scale,
                                        offset: Offset(0, 3 * scale),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/images/add_money_wallet.png',
                                width: 164 * scale,
                                height: (compact ? 100 : 110) * scale,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: compact ? 2 : 8),
                        Text(
                          'Add money to your wallet',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: AppColors.deepNavyText,
                            fontSize: 24 * scale,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.7,
                          ),
                        ),
                        SizedBox(height: 20 * scale),
                        Text(
                          'Enter amount',
                          style: GoogleFonts.inter(
                            color: AppColors.deepNavyText,
                            fontSize: 17 * scale,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8 * scale),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOut,
                          height: 72 * scale,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18 * scale),
                            boxShadow:
                                _typingPulse
                                    ? [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF19BFA6,
                                        ).withValues(alpha: 0.18),
                                        blurRadius: 12,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                    : const [],
                          ),
                          child: TextField(
                            controller: _amountController,
                            focusNode: _amountFocusNode,
                            keyboardType: TextInputType.number,
                            inputFormatters: [_AmountGroupingFormatter()],
                            onChanged: _onAmountChanged,
                            style: GoogleFonts.inter(
                              fontSize: 34 * scale,
                              fontWeight: FontWeight.w800,
                              color: AppColors.deepNavyText,
                              letterSpacing: -0.8,
                            ),
                            decoration: InputDecoration(
                              prefixText: '₹ ',
                              prefixStyle: GoogleFonts.inter(
                                fontSize: 36 * scale,
                                fontWeight: FontWeight.w700,
                                color: AppColors.deepNavyText,
                              ),
                              filled: true,
                              fillColor: AppColors.pureWhite,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20 * scale,
                                vertical: 18 * scale,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18 * scale),
                                borderSide: BorderSide(
                                  color: const Color(0xFFB9C5D1),
                                  width: 1.2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18 * scale),
                                borderSide: BorderSide(
                                  color:
                                      _typingPulse
                                          ? const Color(0xFF19BFA6)
                                          : AppColors.deepTeal,
                                  width: _typingPulse ? 1.8 : 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16 * scale),
                        Row(
                          children:
                              [500, 1000, 2000, 5000].map((amount) {
                                final selected = _selectedAmount == amount;
                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3 * scale,
                                    ),
                                    child: InkWell(
                                      onTap: () => _selectAmount(amount),
                                      borderRadius: BorderRadius.circular(28),
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 220,
                                        ),
                                        curve: Curves.easeInOut,
                                        height: 48 * scale,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          gradient:
                                              selected
                                                  ? const LinearGradient(
                                                    colors: [
                                                      Color(0xFF00B092),
                                                      Color(0xFF006C61),
                                                    ],
                                                  )
                                                  : null,
                                          color:
                                              selected
                                                  ? null
                                                  : AppColors.pureWhite,
                                          border:
                                              selected
                                                  ? null
                                                  : Border.all(
                                                    color: const Color(
                                                      0xFFD5DCE3,
                                                    ),
                                                  ),
                                          borderRadius: BorderRadius.circular(
                                            28,
                                          ),
                                        ),
                                        child: Text(
                                          '₹${amount == 1000
                                              ? '1,000'
                                              : amount == 2000
                                              ? '2,000'
                                              : amount == 5000
                                              ? '5,000'
                                              : '500'}',
                                          maxLines: 1,
                                          style: GoogleFonts.inter(
                                            color:
                                                selected
                                                    ? Colors.white
                                                    : AppColors.deepNavyText,
                                            fontSize: 15 * scale,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        SizedBox(height: 22 * scale),
                        Text(
                          'Pay using',
                          style: GoogleFonts.inter(
                            color: AppColors.deepNavyText,
                            fontSize: 20 * scale,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),
                        SizedBox(height: 10 * scale),
                        _PaymentMethodTile(
                          selected: _selectedMethod == 0,
                          onTap: () => setState(() => _selectedMethod = 0),
                          title: 'HDFC Bank •••• 1234',
                          subtitle: 'Debit Card',
                          logo: _bankLogo(),
                        ),
                        SizedBox(height: 8 * scale),
                        _PaymentMethodTile(
                          selected: _selectedMethod == 1,
                          onTap: () => setState(() => _selectedMethod = 1),
                          title: 'UPI',
                          subtitle: 'Pay from any UPI app',
                          logo: Text(
                            'UPI',
                            style: GoogleFonts.inter(
                              fontSize: 21 * scale,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xFF4B5563),
                            ),
                          ),
                        ),
                        SizedBox(height: 8 * scale),
                        _PaymentMethodTile(
                          selected: _selectedMethod == 2,
                          onTap: () => setState(() => _selectedMethod = 2),
                          title: 'Debit / Credit Card',
                          subtitle: 'Visa, Mastercard, RuPay',
                          logo: _cardLogo(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                color: AppColors.warmIvory,
                padding: EdgeInsets.fromLTRB(20 * scale, 8, 20 * scale, 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 60 * scale,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00B092), Color(0xFF006C61)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: TextButton(
                      onPressed:
                          _selectedAmount > 0
                              ? () => Get.snackbar(
                                'Payment',
                                'Payment flow will continue securely.',
                              )
                              : null,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.white70,
                      ),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.inter(
                          fontSize: 21 * scale,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bankLogo() => Container(
    width: 48,
    height: 42,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Image.asset(
      'assets/images/hdfc.png',
      width: 34,
      height: 34,
      fit: BoxFit.contain,
    ),
  );

  Widget _cardLogo() => SizedBox(
    width: 56,
    height: 42,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 7,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFFEB001B),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: 7,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFFF79E1B),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Text(
            'VISA',
            style: GoogleFonts.inter(
              color: const Color(0xFF143D79),
              fontSize: 13,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  String _formatAmount(int amount) {
    final digits = amount.toString();
    return digits.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
  }
}

class _AmountGroupingFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final grouped = digits.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => ',',
    );
    return TextEditingValue(
      text: grouped,
      selection: TextSelection.collapsed(offset: grouped.length),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  const _PaymentMethodTile({
    required this.selected,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.logo,
  });

  final bool selected;
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final Widget logo;

  @override
  Widget build(BuildContext context) {
    final widthScale =
        (MediaQuery.sizeOf(context).width / 390).clamp(0.88, 1.12).toDouble();
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        constraints: BoxConstraints(minHeight: 66 * widthScale),
        padding: EdgeInsets.symmetric(
          horizontal: 12 * widthScale,
          vertical: 8 * widthScale,
        ),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEAFBF7) : AppColors.pureWhite,
          border: Border.all(
            color: selected ? const Color(0xFF65D9C6) : const Color(0xFFD9DEE5),
            width: selected ? 1.3 : 1,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            SizedBox(width: 58 * widthScale, child: Center(child: logo)),
            Container(
              width: 1,
              height: 38 * widthScale,
              margin: EdgeInsets.symmetric(horizontal: 10 * widthScale),
              color: const Color(0xFFD7DEE5),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: AppColors.deepNavyText,
                      fontSize: 16 * widthScale,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF596575),
                      fontSize: 13.5 * widthScale,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10 * widthScale),
            selected
                ? Container(
                  width: 26,
                  height: 26,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00B092),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 19),
                )
                : Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF8B929A),
                      width: 1.5,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
