import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';
import 'package:payzen_app/screens/wallet/widgets/wallet_activation_progress.dart';

class WalletAddressScreen extends StatefulWidget {
  const WalletAddressScreen({super.key});

  @override
  State<WalletAddressScreen> createState() => _WalletAddressScreenState();
}

class _WalletAddressScreenState extends State<WalletAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController(
    text: 'A-1203, Sunrise Residency',
  );
  final _localityController = TextEditingController(text: 'Hinjawadi Phase 2');
  final _cityController = TextEditingController(text: 'Pune');
  final _stateController = TextEditingController(text: 'Maharashtra');
  final _pinController = TextEditingController(text: '411057');

  @override
  void dispose() {
    _addressController.dispose();
    _localityController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _continue() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    Get.toNamed(AppRoutes.walletVideoKyc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppBar(
        title: Text(
          'Activate PayZen Wallet',
          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 17),
        ),
        backgroundColor: AppColors.deepTeal,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: Image.asset(
          'assets/images/header_waves_bg.jpg',
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        actions: [
          IconButton(
            tooltip: 'Address help',
            onPressed:
                () => Get.snackbar(
                  'Address from Aadhaar',
                  'Review the sample address and edit it if needed.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.deepTeal,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(16),
                ),
            icon: const Icon(Icons.help_outline_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 158,
            child: Image(
              image: AssetImage('assets/images/header_waves_bg.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Positioned.fill(
            top: 142,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxHeight < 780;
                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(
                    20,
                    compact ? 152 : 164,
                    20,
                    compact ? 16 : 28,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Verify your address',
                                        style: GoogleFonts.inter(
                                          color: AppColors.deepNavyText,
                                          fontSize: compact ? 21 : 24,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Review your residential address for Wallet KYC.',
                                        style: GoogleFonts.inter(
                                          color: AppColors.mutedSlate,
                                          fontSize: compact ? 13 : 14,
                                          height: 1.35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                _AddressIllustration(size: compact ? 62 : 76),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE9F8F4),
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: const Color(0xFFCDEDE4),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.verified_user_outlined,
                                    color: AppColors.deepTeal,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Sample address loaded from Aadhaar (mock preview)',
                                      style: GoogleFonts.inter(
                                        color: AppColors.deepTeal,
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: compact ? 14 : 18),
                            _AddressField(
                              label: 'Address (House / Flat / Building No.)',
                              controller: _addressController,
                              icon: Icons.location_on_outlined,
                              compact: compact,
                              validator: _requiredValidator,
                            ),
                            SizedBox(height: compact ? 10 : 13),
                            _AddressField(
                              label: 'Area / Locality',
                              controller: _localityController,
                              icon: Icons.home_work_outlined,
                              compact: compact,
                              validator: _requiredValidator,
                            ),
                            SizedBox(height: compact ? 10 : 13),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _AddressField(
                                    label: 'City',
                                    controller: _cityController,
                                    compact: compact,
                                    validator: _requiredValidator,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _AddressField(
                                    label: 'State',
                                    controller: _stateController,
                                    compact: compact,
                                    validator: _requiredValidator,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: compact ? 10 : 13),
                            _AddressField(
                              label: 'PIN Code',
                              controller: _pinController,
                              icon: Icons.pin_drop_outlined,
                              compact: compact,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(6),
                              ],
                              validator:
                                  (value) =>
                                      RegExp(
                                            r'^\d{6}$',
                                          ).hasMatch(value?.trim() ?? '')
                                          ? null
                                          : 'Enter a valid 6-digit PIN code',
                            ),
                            SizedBox(height: compact ? 13 : 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAF8F4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.info_outline_rounded,
                                    color: AppColors.deepTeal,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'This address will be used for wallet verification and compliance.',
                                      style: GoogleFonts.inter(
                                        color: AppColors.deepNavyText,
                                        fontSize: 12,
                                        height: 1.35,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: compact ? 12 : 16),
                            _WalletFlowButton(
                              label: 'Continue to Video KYC',
                              icon: Icons.arrow_forward_rounded,
                              onPressed: _continue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 15,
            left: 20,
            right: 20,
            child: WalletActivationProgress(
              activeStep: 3,
              compact: MediaQuery.sizeOf(context).width < 380,
              darkBackground: true,
            ),
          ),
        ],
      ),
    );
  }

  String? _requiredValidator(String? value) =>
      value == null || value.trim().isEmpty ? 'This field is required' : null;
}

class _AddressField extends StatelessWidget {
  const _AddressField({
    required this.label,
    required this.controller,
    required this.compact,
    this.icon,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final bool compact;
  final IconData? icon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.inter(
          color: AppColors.deepNavyText,
          fontSize: compact ? 12.5 : 13.5,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 5),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        style: GoogleFonts.inter(
          color: AppColors.deepNavyText,
          fontSize: compact ? 13 : 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixIcon:
              icon == null
                  ? null
                  : Icon(icon, color: AppColors.deepTeal, size: 19),
          prefixIconConstraints:
              icon == null
                  ? null
                  : const BoxConstraints(minWidth: 42, minHeight: 44),
          isDense: true,
          filled: true,
          fillColor: const Color(0xFFFCFDFD),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 13,
            vertical: compact ? 13 : 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFC8D2D8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFC8D2D8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.electricMint,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.errorCoral),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
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

class _AddressIllustration extends StatelessWidget {
  const _AddressIllustration({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size * 0.88,
          height: size * 0.88,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFE5FAF4), Color(0xFFC9F0E7)],
            ),
          ),
        ),
        Icon(Icons.home_rounded, color: AppColors.deepTeal, size: size * 0.59),
        Positioned(
          right: 0,
          bottom: 2,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: AppColors.electricMint,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on_rounded,
              color: Colors.white,
              size: size * 0.28,
            ),
          ),
        ),
      ],
    ),
  );
}

class _WalletFlowButton extends StatelessWidget {
  const _WalletFlowButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 54,
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF003840), Color(0xFF007568)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22003840),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 10),
            Icon(icon, size: 20),
          ],
        ),
      ),
    ),
  );
}
