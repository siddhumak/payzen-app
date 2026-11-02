import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/app_gradients.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';

class WalletActivationScreen extends StatefulWidget {
  const WalletActivationScreen({super.key});

  @override
  State<WalletActivationScreen> createState() => _WalletActivationScreenState();
}

class _WalletActivationScreenState extends State<WalletActivationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _heroAnimation;
  late final Animation<double> _contentAnimation;
  late final Animation<double> _benefitsAnimation;
  late final Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _heroAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.55, curve: Curves.easeOutBack),
    );
    _contentAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.72, curve: Curves.easeOutCubic),
    );
    _benefitsAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.38, 0.88, curve: Curves.easeOutCubic),
    );
    _buttonAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.58, 1, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _fadeSlide({
    required Animation<double> animation,
    required Widget child,
    double offset = 0.14,
  }) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, offset),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.warmIvory,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        body: ColoredBox(
          color: AppColors.warmIvory,
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxHeight < 700;
                final illustrationSize = compact ? 225.0 : 260.0;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/payzen_logo.png',
                            width: 34,
                            height: 34,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'PayZen',
                            style: GoogleFonts.inter(
                              color: AppColors.deepNavyText,
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          22,
                          compact ? 2 : 8,
                          22,
                          12,
                        ),
                        child: Column(
                          children: [
                            ScaleTransition(
                              scale: _heroAnimation,
                              child: SizedBox(
                                width: illustrationSize,
                                height: illustrationSize,
                                child: Image.asset(
                                  'assets/images/wallet_activation_hero.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            _fadeSlide(
                              animation: _contentAnimation,
                              child: Column(
                                children: [
                                  ShaderMask(
                                    shaderCallback:
                                        AppGradients.headingText.createShader,
                                    child: Text(
                                      'Activate your\nPayZen Wallet',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: compact ? 25 : 29,
                                        fontWeight: FontWeight.w800,
                                        height: 1.12,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text.rich(
                                    TextSpan(
                                      style: GoogleFonts.inter(
                                        color: AppColors.deepTeal,
                                        fontSize: 15,
                                        height: 1.45,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      children: const [
                                        TextSpan(
                                          text:
                                              'Add money, pay for services and ',
                                        ),
                                        TextSpan(
                                          text: 'enjoy exclusive rewards.',
                                          style: TextStyle(
                                            color: AppColors.deepTeal,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: compact ? 16 : 22),
                            _fadeSlide(
                              animation: _benefitsAnimation,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.pureWhite,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.borderLight,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.cardShadow,
                                      blurRadius: 12,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Column(
                                  children: [
                                    _WalletBenefit(
                                      imagePath:
                                          'assets/images/icon_3d_electricity.png',
                                      label: 'Instant payments',
                                    ),
                                    _WalletBenefit(
                                      imagePath:
                                          'assets/images/wallet_benefit_security.png',
                                      label: 'Secure & regulated',
                                    ),
                                    _WalletBenefit(
                                      imagePath:
                                          'assets/images/wallet_benefit_rewards.png',
                                      label: 'Exciting rewards',
                                      showDivider: false,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _fadeSlide(
                      animation: _buttonAnimation,
                      offset: 0.25,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.primarydark,
                                  AppColors.primary,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: FilledButton(
                              onPressed:
                                  () => Get.toNamed(
                                    AppRoutes.walletPanVerification,
                                  ),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Proceed to Activation',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(LucideIcons.arrowRight, size: 19),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _WalletBenefit extends StatelessWidget {
  const _WalletBenefit({
    required this.imagePath,
    required this.label,
    this.showDivider = true,
  });

  final String imagePath;
  final String label;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Row(
            children: [
              SizedBox(
                width: 34,
                height: 34,
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    color: AppColors.deepNavyText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider) Divider(height: 1, color: AppColors.borderLight),
      ],
    );
  }
}
