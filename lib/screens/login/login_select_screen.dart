import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';

class LoginSelectionScreen extends StatefulWidget {
  const LoginSelectionScreen({super.key});

  @override
  State<LoginSelectionScreen> createState() => _LoginSelectionScreenState();
}

class _LoginSelectionScreenState extends State<LoginSelectionScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _mobileController = TextEditingController();
  bool _isValidNumber = false;

  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.warmIvory,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    _mobileController.addListener(() {
      final isValid = _mobileController.text.trim().length == 10;
      if (isValid != _isValidNumber) {
        setState(() {
          _isValidNumber = isValid;
        });
      }
    });

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -4.0, end: 4.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (_isValidNumber) {
      Get.toNamed(
        AppRoutes.otpLogin,
        arguments: {'phone': _mobileController.text.trim()},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final size = media.size;

    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),

                        // ---------------------------------------------------
                        // 1. Back Navigation Button
                        // ---------------------------------------------------
                        GestureDetector(
                          onTap: () {
                            if (Navigator.canPop(context)) {
                              Get.back();
                            } else {
                              Get.offNamed(AppRoutes.first);
                            }
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              LucideIcons.arrowLeft,
                              size: 24,
                              color: AppColors.deepNavyText,
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.025),

                        // ---------------------------------------------------
                        // 2. Heading: "Welcome to PayZen"
                        // ---------------------------------------------------
                        Text(
                          'Welcome to',
                          style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: AppColors.deepNavyText,
                            letterSpacing: -0.5,
                            height: 1.15,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Pay',
                                style: GoogleFonts.inter(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.deepNavyText,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              TextSpan(
                                text: 'Zen',
                                style: GoogleFonts.inter(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.electricMint,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Subtitle
                        Text(
                          'Enter your mobile number to\ncontinue',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mutedSlate,
                            height: 1.35,
                          ),
                        ),

                        SizedBox(height: size.height * 0.035),

                        // ---------------------------------------------------
                        // 3. Mobile Number Input Card
                        // ---------------------------------------------------
                        Container(
                          height: 58,
                          decoration: BoxDecoration(
                            color: AppColors.pureWhite,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _isValidNumber
                                  ? AppColors.deepTeal.withOpacity(0.5)
                                  : const Color(0xFFDCE2E8),
                              width: 1.2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x06061C2B),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Country Code
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0, right: 12.0),
                                child: Text(
                                  '+91',
                                  style: GoogleFonts.inter(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.deepNavyText,
                                  ),
                                ),
                              ),

                              // Vertical Divider
                              Container(
                                width: 1.2,
                                height: 26,
                                color: const Color(0xFFE2E8F0),
                              ),

                              const SizedBox(width: 14),

                              // Input Field
                              Expanded(
                                child: TextField(
                                  controller: _mobileController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.deepNavyText,
                                    letterSpacing: 0.5,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    filled: false,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                    hintText: 'Enter mobile number',
                                    hintStyle: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        // ---------------------------------------------------
                        // 4. Continue CTA Button
                        // ---------------------------------------------------
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: _isValidNumber ? _onContinue : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.deepTeal,
                              disabledBackgroundColor: const Color(0xFFB5C6D1),
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 22),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Text(
                                  'Continue',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  LucideIcons.arrowRight,
                                  size: 19,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ---------------------------------------------------
                        // 5. Hero 3D Security Phone Graphic (Adaptive)
                        // ---------------------------------------------------
                        Expanded(
                          child: Center(
                            child: AnimatedBuilder(
                              animation: _floatController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _floatAnimation.value),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxHeight: size.height * 0.38,
                                    ),
                                    child: Image.asset(
                                      'assets/images/login_security_hero.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // ---------------------------------------------------
                        // 6. Bottom Trust Badge
                        // ---------------------------------------------------
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0, top: 8.0),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Shield with checkmark icon
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF168568),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // Divider
                                Container(
                                  width: 1,
                                  height: 28,
                                  color: const Color(0xFFDCE2E7),
                                ),

                                const SizedBox(width: 12),

                                // Security Note
                                Flexible(
                                  child: Text(
                                    'Your data is safe and secure\nwith bank-grade encryption',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.mutedSlate,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
    );
  }
}
