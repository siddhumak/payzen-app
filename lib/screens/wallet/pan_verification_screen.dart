import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';
import 'package:payzen_app/screens/wallet/widgets/wallet_activation_progress.dart';

class PanVerificationScreen extends StatefulWidget {
  const PanVerificationScreen({super.key});

  @override
  State<PanVerificationScreen> createState() => _PanVerificationScreenState();
}

class _PanVerificationScreenState extends State<PanVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _panController = TextEditingController();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _panController.dispose();
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDateOfBirth() async {
    FocusScope.of(context).unfocus();
    final today = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(today.year - 18, today.month, today.day),
      firstDate: DateTime(1900),
      lastDate: today,
      helpText: 'Select date of birth',
      builder:
          (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.deepTeal,
                onPrimary: Colors.white,
                surface: AppColors.pureWhite,
                onSurface: AppColors.deepNavyText,
              ),
            ),
            child: child!,
          ),
    );

    if (selectedDate == null || !mounted) return;
    _dateController.text =
        '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';
  }

  void _verifyPanDetails() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    Get.toNamed(
      AppRoutes.otpLogin,
      arguments: const {'flow': 'wallet_activation'},
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
          icon: const Icon(
            LucideIcons.arrowLeft,
            color: AppColors.deepNavyText,
            size: 22,
          ),
          tooltip: 'Back',
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxHeight < 740;
            final titleGap = compact ? 14.0 : 20.0;
            final stepGap = compact ? 18.0 : 26.0;
            final fieldGap = compact ? 12.0 : 16.0;
            final consentGap = compact ? 18.0 : 24.0;
            final buttonGap = compact ? 24.0 : 32.0;

            final content = Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 2),
                        // Title: Activate PayZen Wallet matching reference styling
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.inter(
                              fontSize: compact ? 25 : 28,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.4,
                              color: AppColors.deepNavyText,
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
                        ),
                        SizedBox(height: titleGap),

                        // Compact Step Indicator
                        _PanStepIndicator(compact: compact),
                        SizedBox(height: stepGap),

                        // PAN Card Number Input
                        _PanFormField(
                          label: 'PAN Card Number',
                          controller: _panController,
                          hint: 'Enter PAN (e.g. ABCDE1234F)',
                          icon: LucideIcons.creditCard,
                          compact: compact,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9]'),
                            ),
                            LengthLimitingTextInputFormatter(10),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.toUpperCase(),
                                selection: newValue.selection,
                              ),
                            ),
                          ],
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your PAN number';
                            }
                            if (!RegExp(
                              r'^[A-Z]{5}[0-9]{4}[A-Z]$',
                            ).hasMatch(value.trim().toUpperCase())) {
                              return 'Enter a valid 10-character PAN';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: fieldGap),

                        // Full Name Input
                        _PanFormField(
                          label: 'Full name as per PAN',
                          controller: _nameController,
                          hint: 'Enter your full name',
                          icon: LucideIcons.user,
                          compact: compact,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your name as printed on your PAN';
                            }
                            if (value.trim().length < 2) {
                              return 'Enter your full name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: fieldGap),

                        // Date of Birth Input
                        _PanFormField(
                          label: 'Date of birth',
                          controller: _dateController,
                          hint: 'DD / MM / YYYY',
                          icon: LucideIcons.calendarDays,
                          compact: compact,
                          readOnly: true,
                          onTap: _selectDateOfBirth,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Select your date of birth';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: consentGap),

                        // KYC Consent Card with Glowing Shield Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: compact ? 14 : 18,
                            vertical: compact ? 12 : 14,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F6F3),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFD4EDE5),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: compact ? 32 : 36,
                                height: compact ? 32 : 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF00A896),
                                      Color(0xFF007A6C),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF009384,
                                      ).withOpacity(0.28),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  LucideIcons.check,
                                  size: 22,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: compact ? 12 : 16),
                              Expanded(
                                child: Text(
                                  'By proceeding, you agree to verify your PAN details with NSDL/CIDR and link it to your PayZen Wallet.',
                                  style: GoogleFonts.inter(
                                    color: AppColors.deepNavyText,
                                    fontSize: compact ? 13 : 14,
                                    height: 1.3,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: buttonGap),

                        // Verify PAN Details Button (Directly below consent card)
                        SizedBox(
                          height: compact ? 50 : 54,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF003840), Color(0xFF007568)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF003840,
                                  ).withOpacity(0.24),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _verifyPanDetails,
                                borderRadius: BorderRadius.circular(32),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Verify PAN Details',
                                      style: GoogleFonts.inter(
                                        fontSize: compact ? 16 : 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Icon(
                                      LucideIcons.arrowRight,
                                      size: compact ? 20 : 22,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
              ),
            );

            if (constraints.maxHeight < 620 ||
                MediaQuery.viewInsetsOf(context).bottom > 0) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: content,
                ),
              );
            }

            return content;
          },
        ),
      ),
    );
  }
}

class _PanFormField extends StatelessWidget {
  const _PanFormField({
    required this.label,
    required this.controller,
    required this.hint,
    required this.compact,
    this.icon,
    this.prefixWidget,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.readOnly = false,
    this.onTap,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final bool compact;
  final IconData? icon;
  final Widget? prefixWidget;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.deepNavyText,
            fontSize: compact ? 15 : 16,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.1,
          ),
        ),
        SizedBox(height: compact ? 5 : 7),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters,
          readOnly: readOnly,
          onTap: onTap,
          validator: validator,
          style: GoogleFonts.inter(
            color: AppColors.deepNavyText,
            fontSize: compact ? 15 : 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            isDense: false,
            constraints: BoxConstraints(minHeight: compact ? 48 : 52),
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF94A3B8),
              fontSize: compact ? 14 : 15,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: SizedBox(
              width: 68,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  prefixWidget ??
                      Icon(
                        icon,
                        size: compact ? 22 : 24,
                        color: const Color(0xFF5D6B75),
                      ),
                  const SizedBox(width: 14),
                  Container(
                    width: 1,
                    height: 28,
                    color: const Color(0xFFD6DADD),
                  ),
                ],
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 68,
              minHeight: compact ? 48 : 52,
            ),
            filled: true,
            fillColor: AppColors.pureWhite,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: compact ? 11 : 13,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFE2E8F0),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFE2E8F0),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFF009384),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: AppColors.errorCoral),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: AppColors.errorCoral,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PanStepIndicator extends StatelessWidget {
  const _PanStepIndicator({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return WalletActivationProgress(activeStep: 0, compact: compact);
  }
}
