import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';
import 'package:payzen_app/screens/wallet/widgets/wallet_activation_progress.dart';

class AadhaarVerificationScreen extends StatefulWidget {
  const AadhaarVerificationScreen({super.key});

  @override
  State<AadhaarVerificationScreen> createState() =>
      _AadhaarVerificationScreenState();
}

class _AadhaarVerificationScreenState extends State<AadhaarVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  bool _useVid = false;
  bool _consentGiven = true;

  void _selectAadhaarType(bool useVid) {
    final maxDigits = useVid ? 16 : 12;
    final currentDigits = _numberController.text.replaceAll(RegExp(r'\D'), '');
    final digits =
        currentDigits.length > maxDigits
            ? currentDigits.substring(0, maxDigits)
            : currentDigits;

    setState(() {
      _useVid = useVid;
      _numberController.value = TextEditingValue(
        text: _groupDigits(digits),
        selection: TextSelection.collapsed(offset: _groupDigits(digits).length),
      );
    });
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _continue() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (!_consentGiven) {
      Get.snackbar(
        'Consent required',
        'Please agree to the Aadhaar consent to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.deepTeal,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    Get.toNamed(
      AppRoutes.otpLogin,
      arguments: const {'flow': 'wallet_aadhaar'},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppBar(
        backgroundColor: AppColors.warmIvory,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 48,
        leading: IconButton(
          onPressed: Get.back,
          tooltip: 'Back',
          icon: const Icon(
            LucideIcons.arrowLeft,
            color: AppColors.deepNavyText,
            size: 22,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxHeight < 700;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 4, 24, 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text.rich(
                          TextSpan(
                            style: GoogleFonts.inter(
                              color: AppColors.deepNavyText,
                              fontSize: compact ? 25 : 28,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                            children: const [
                              TextSpan(text: 'Activate '),
                              TextSpan(
                                text: 'PayZen',
                                style: TextStyle(color: Color(0xFF009384)),
                              ),
                              TextSpan(text: ' Wallet'),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: compact ? 18 : 24),
                        _ActivationProgress(compact: compact),
                        SizedBox(height: compact ? 24 : 32),
                        Text('Choose type', style: _labelStyle(compact)),
                        SizedBox(height: compact ? 8 : 14),
                        Row(
                          children: [
                            Expanded(
                              child: _TypeOption(
                                label: 'Aadhaar',
                                selected: !_useVid,
                                compact: compact,
                                onTap: () => _selectAadhaarType(false),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _TypeOption(
                                label: 'Aadhaar VID',
                                selected: _useVid,
                                compact: compact,
                                onTap: () => _selectAadhaarType(true),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: compact ? 18 : 24),
                        Text(
                          _useVid ? 'Aadhaar VID' : 'Aadhaar number',
                          style: _labelStyle(compact),
                        ),
                        const SizedBox(height: 7),
                        TextFormField(
                          controller: _numberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            _GroupedDigitsFormatter(
                              maxDigits: _useVid ? 16 : 12,
                            ),
                          ],
                          style: GoogleFonts.inter(
                            color: AppColors.deepNavyText,
                            fontSize: compact ? 15 : 17,
                            fontWeight: FontWeight.w500,
                          ),
                          validator: (value) {
                            final expectedLength = _useVid ? 16 : 12;
                            final entered = value ?? '';
                            final digits = entered.replaceAll(
                              RegExp(r'\s'),
                              '',
                            );
                            if (!RegExp(r'^[0-9 ]*$').hasMatch(entered) ||
                                digits.length != expectedLength) {
                              return _useVid
                                  ? 'Enter your 16-digit Aadhaar VID'
                                  : 'Enter your 12-digit Aadhaar number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText:
                                _useVid
                                    ? 'XXXX XXXX XXXX XXXX'
                                    : 'XXXX XXXX XXXX',
                            hintStyle: GoogleFonts.inter(
                              color: const Color(0xFF818A91),
                              fontSize: compact ? 15 : 17,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                            prefixIcon: const _AadhaarMark(),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 82,
                              minHeight: 52,
                            ),
                            filled: true,
                            fillColor: AppColors.pureWhite,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: compact ? 12 : 15,
                            ),
                            border: _fieldBorder(),
                            enabledBorder: _fieldBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: const BorderSide(
                                color: Color(0xFF009384),
                                width: 1.5,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: const BorderSide(
                                color: AppColors.errorCoral,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: compact ? 20 : 28),
                        Container(
                          padding: EdgeInsets.all(compact ? 16 : 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF7F3),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Aadhaar consent',
                                      style: GoogleFonts.inter(
                                        color: AppColors.deepNavyText,
                                        fontSize: compact ? 18 : 21,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    LucideIcons.info,
                                    color: AppColors.deepNavyText,
                                    size: 23,
                                  ),
                                ],
                              ),
                              SizedBox(height: compact ? 10 : 14),
                              Text(
                                'I understand that PayZen will collect and share my Aadhaar number/VID with UIDAI for OTP-based e-KYC authentication and upon successful authentication, UIDAI will share my KYC details.',
                                style: GoogleFonts.inter(
                                  color: AppColors.deepNavyText,
                                  fontSize: compact ? 13 : 15,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: compact ? 12 : 18),
                        InkWell(
                          onTap:
                              () => setState(
                                () => _consentGiven = !_consentGiven,
                              ),
                          borderRadius: BorderRadius.circular(8),
                          child: Row(
                            children: [
                              Checkbox(
                                value: _consentGiven,
                                activeColor: const Color(0xFF008774),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onChanged:
                                    (value) => setState(
                                      () => _consentGiven = value ?? false,
                                    ),
                              ),
                              Expanded(
                                child: Text(
                                  'I agree to the Aadhaar consent',
                                  style: GoogleFonts.inter(
                                    color: AppColors.deepNavyText,
                                    fontSize: compact ? 15 : 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: compact ? 20 : 30),
                        SizedBox(
                          height: compact ? 52 : 58,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF003840), Color(0xFF007568)],
                              ),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: FilledButton(
                              onPressed: _continue,
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Continue to Verify',
                                    style: GoogleFonts.inter(
                                      fontSize: compact ? 17 : 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(
                                    LucideIcons.arrowRight,
                                    size: compact ? 20 : 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  TextStyle _labelStyle(bool compact) => GoogleFonts.inter(
    color: AppColors.deepNavyText,
    fontSize: compact ? 17 : 19,
    fontWeight: FontWeight.w800,
  );

  OutlineInputBorder _fieldBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: const BorderSide(color: Color(0xFFD7DADD)),
  );
}

String _groupDigits(String digits) {
  final grouped = StringBuffer();
  for (var index = 0; index < digits.length; index++) {
    if (index > 0 && index % 4 == 0) grouped.write(' ');
    grouped.write(digits[index]);
  }
  return grouped.toString();
}

class _GroupedDigitsFormatter extends TextInputFormatter {
  const _GroupedDigitsFormatter({required this.maxDigits});

  final int maxDigits;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limitedDigits =
        digits.length > maxDigits ? digits.substring(0, maxDigits) : digits;
    final selectionOffset =
        newValue.selection.extentOffset.clamp(0, newValue.text.length).toInt();
    final digitsBeforeCursor =
        newValue.text
            .substring(0, selectionOffset)
            .replaceAll(RegExp(r'\D'), '')
            .length
            .clamp(0, limitedDigits.length)
            .toInt();
    final formatted = _groupDigits(limitedDigits);
    var cursor = 0;
    var seenDigits = 0;
    while (cursor < formatted.length && seenDigits < digitsBeforeCursor) {
      if (formatted.codeUnitAt(cursor) != 32) seenDigits++;
      cursor++;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursor),
      composing: TextRange.empty,
    );
  }
}

class _AadhaarMark extends StatelessWidget {
  const _AadhaarMark();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82,
      child: Row(
        children: [
          const SizedBox(width: 14),
          Image.asset(
            'assets/images/Glossy Red Fingerprint Sunburst Logo.png',
            width: 52,
            height: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          const SizedBox(
            height: 34,
            child: VerticalDivider(
              width: 1,
              thickness: 1,
              color: Color(0xFFADB3B8),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivationProgress extends StatelessWidget {
  const _ActivationProgress({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return WalletActivationProgress(activeStep: 1, compact: compact);
  }
}

class _TypeOption extends StatelessWidget {
  const _TypeOption({
    required this.label,
    required this.selected,
    required this.compact,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool compact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: compact ? 28 : 34,
              height: compact ? 28 : 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      selected
                          ? const Color(0xFF008774)
                          : const Color(0xFF899198),
                  width: selected ? 2 : 1.5,
                ),
              ),
              child:
                  selected
                      ? Container(
                        width: compact ? 17 : 21,
                        height: compact ? 17 : 21,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF008774),
                        ),
                      )
                      : null,
            ),
            SizedBox(width: compact ? 9 : 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  color: AppColors.deepNavyText,
                  fontSize: compact ? 15 : 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
