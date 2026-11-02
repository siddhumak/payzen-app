import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';

class WalletActivationCompleteScreen extends StatefulWidget {
  const WalletActivationCompleteScreen({super.key});

  @override
  State<WalletActivationCompleteScreen> createState() =>
      _WalletActivationCompleteScreenState();
}

class _WalletActivationCompleteScreenState
    extends State<WalletActivationCompleteScreen>
    with TickerProviderStateMixin {
  late final ConfettiController _confettiController = ConfettiController(
    duration: const Duration(seconds: 4),
  );
  late final AnimationController _successController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 850),
  );

  @override
  void initState() {
    super.initState();
    _successController.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _successController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF03141F),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF03141F),
        body: Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF03141F), Color(0xFF00343D)],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  numberOfParticles: 34,
                  maxBlastForce: 20,
                  minBlastForce: 8,
                  gravity: 0.16,
                  emissionFrequency: 0.035,
                  colors: const [
                    AppColors.electricMint,
                    Color(0xFF55FFF0),
                    Color(0xFFFFC72C),
                    Colors.white,
                  ],
                ),
              ),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxHeight < 760;
                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      24,
                      compact ? 14 : 24,
                      24,
                      compact ? 14 : 24,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight -
                            (compact ? 28 : 48),
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/payzen_logo.png',
                                    width: compact ? 34 : 40,
                                    height: compact ? 34 : 40,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'PayZen',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: compact ? 24 : 28,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: compact ? 14 : 22),
                              Stack(
                                alignment: Alignment.topCenter,
                                clipBehavior: Clip.none,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: compact ? 40 : 52,
                                    ),
                                    child: Image.asset(
                                      'assets/images/wallet_activation_hero.png',
                                      width: compact ? 250 : 300,
                                      height: compact ? 210 : 250,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  ScaleTransition(
                                    scale: CurvedAnimation(
                                      parent: _successController,
                                      curve: Curves.elasticOut,
                                    ),
                                    child: Container(
                                      width: compact ? 88 : 100,
                                      height: compact ? 88 : 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xFF007E7C),
                                        border: Border.all(
                                          color: const Color(0xFF55FFF0),
                                          width: 3,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF19C6AE)
                                                .withOpacity(0.55),
                                            blurRadius: 24,
                                            spreadRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        LucideIcons.check,
                                        color: Colors.white,
                                        size: compact ? 52 : 60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: compact ? 4 : 10),
                              Text.rich(
                                TextSpan(
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: compact ? 31 : 38,
                                    fontWeight: FontWeight.w800,
                                    height: 1.08,
                                    letterSpacing: -0.8,
                                  ),
                                  children: const [
                                    TextSpan(text: 'Wallet activation\n'),
                                    TextSpan(
                                      text: 'complete',
                                      style: TextStyle(
                                        color: Color(0xFF19C6AE),
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: compact ? 8 : 12),
                              Text(
                                'Your PayZen Wallet is ready to use.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFFE2F5F4),
                                  fontSize: compact ? 15 : 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: compact ? 20 : 28),
                              Container(
                                padding: EdgeInsets.all(compact ? 14 : 18),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF07313B).withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: const Color(0xFF168C95),
                                    width: 1.2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/payzen_wallet_art.png',
                                        width: compact ? 64 : 76,
                                        height: compact ? 64 : 76,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: compact ? 10 : 16),
                                    Container(
                                      width: 1,
                                      height: compact ? 68 : 82,
                                      color: const Color(0xFF168C95),
                                    ),
                                    SizedBox(width: compact ? 12 : 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Wallet Activated',
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: compact ? 17 : 20,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'You can now add money, make payments and earn rewards.',
                                            style: GoogleFonts.inter(
                                              color: const Color(0xFFE2F5F4),
                                              fontSize: compact ? 13 : 15,
                                              height: 1.4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: compact ? 8 : 12),
                                    Container(
                                      width: compact ? 34 : 42,
                                      height: compact ? 34 : 42,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.electricMint,
                                      ),
                                      child: const Icon(
                                        LucideIcons.check,
                                        color: Color(0xFF00343D),
                                        size: 23,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: compact ? 24 : 34),
                              SizedBox(
                                width: double.infinity,
                                height: compact ? 56 : 64,
                                child: FilledButton(
                                  onPressed: () =>
                                      Get.offAllNamed(AppRoutes.wallet),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.electricMint,
                                    foregroundColor: const Color(0xFF00343D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(36),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Go to Wallet',
                                        style: GoogleFonts.inter(
                                          fontSize: compact ? 19 : 23,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Icon(
                                        LucideIcons.arrowRight,
                                        size: compact ? 23 : 27,
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
          ],
        ),
      ),
    );
  }
}
