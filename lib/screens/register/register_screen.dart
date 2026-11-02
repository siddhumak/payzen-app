import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  late final String _verifiedPhone;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    _verifiedPhone = args is Map && args['phone'] != null
        ? args['phone'].toString()
        : '';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _createAccount() {
    if (!_formKey.currentState!.validate()) return;
    Get.offAllNamed(AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    final scale = (screen.width / 390).clamp(0.88, 1.12).toDouble();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.warmIvory,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(24 * scale, 12, 24 * scale, 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight - 36),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: Get.back,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        icon: const Icon(
                          LucideIcons.arrowLeft,
                          color: AppColors.deepNavyText,
                          size: 24,
                        ),
                        tooltip: 'Back',
                      ),
                      SizedBox(height: 20 * scale),
                      Text(
                        'Set up your',
                        style: GoogleFonts.inter(
                          color: AppColors.deepNavyText,
                          fontSize: 30 * scale,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.6,
                          height: 1.12,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(
                            color: AppColors.deepNavyText,
                            fontSize: 30 * scale,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.6,
                            height: 1.12,
                          ),
                          children: const [
                            TextSpan(text: 'profile', style: TextStyle(color: AppColors.electricMint)),
                          ],
                        ),
                      ),
                      SizedBox(height: 10 * scale),
                      Text(
                        'Tell us a bit about yourself to finish setting up PayZen.',
                        style: GoogleFonts.inter(
                          color: AppColors.mutedSlate,
                          fontSize: 15 * scale,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 24 * scale),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF8F4),
                          border: Border.all(color: const Color(0xFFBDEADF)),
                          borderRadius: BorderRadius.circular(16 * scale),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              LucideIcons.checkCircle,
                              color: AppColors.deepTeal,
                              size: 22,
                            ),
                            SizedBox(width: 12 * scale),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Verified mobile number',
                                    style: GoogleFonts.inter(
                                      color: AppColors.deepNavyText,
                                      fontSize: 14 * scale,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    _verifiedPhone,
                                    style: GoogleFonts.inter(
                                      color: AppColors.mutedSlate,
                                      fontSize: 14 * scale,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 22 * scale),
                      _fieldLabel('Full name', scale),
                      SizedBox(height: 7 * scale),
                      _textField(
                        controller: _fullNameController,
                        hint: 'Enter your full name',
                        icon: LucideIcons.user,
                        scale: scale,
                        validator: (value) => (value == null || value.trim().isEmpty)
                            ? 'Enter your full name'
                            : null,
                      ),
                      SizedBox(height: 16 * scale),
                      _fieldLabel('Email address (optional)', scale),
                      SizedBox(height: 7 * scale),
                      _textField(
                        controller: _emailController,
                        hint: 'Enter your email address',
                        icon: LucideIcons.mail,
                        scale: scale,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          final email = value?.trim() ?? '';
                          if (email.isNotEmpty &&
                              !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 26 * scale),
                      SizedBox(
                        width: double.infinity,
                        height: 56 * scale,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00B092), Color(0xFF006C61)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextButton(
                            onPressed: _createAccount,
                            style: TextButton.styleFrom(foregroundColor: Colors.white),
                            child: Text(
                              'Save & Continue',
                              style: GoogleFonts.inter(
                                fontSize: 16 * scale,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12 * scale),
                      Center(
                        child: Text(
                          'Secure signup with mobile verification',
                          style: GoogleFonts.inter(
                            color: AppColors.mutedSlate,
                            fontSize: 12 * scale,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String text, double scale) => Text(
        text,
        style: GoogleFonts.inter(
          color: AppColors.deepNavyText,
          fontSize: 14 * scale,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required double scale,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.name,
    TextCapitalization textCapitalization = TextCapitalization.words,
  }) {
    final radius = BorderRadius.circular(15 * scale);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: const [
          BoxShadow(
            color: Color(0x09061C2B),
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        validator: validator,
        style: GoogleFonts.inter(
          color: AppColors.deepNavyText,
          fontSize: 15 * scale,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            color: AppColors.mutedSlate,
            fontSize: 14 * scale,
          ),
          prefixIcon: Icon(icon, color: AppColors.deepTeal, size: 20),
          filled: true,
          fillColor: AppColors.pureWhite,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14 * scale,
            vertical: 17 * scale,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(color: AppColors.borderLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(color: AppColors.electricMint, width: 1.6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(color: AppColors.errorCoral),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(color: AppColors.errorCoral, width: 1.5),
          ),
        ),
      ),
    );
  }
}
