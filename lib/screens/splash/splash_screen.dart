import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payzen_app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // 1. Entrance animation controller
  late AnimationController _entranceController;
  late Animation<double> _bgFade;
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _subtitlesSlide;
  late Animation<double> _subtitlesFade;
  late Animation<double> _bottomFade;

  // 2. Floating physics controller for logo (no glow)
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  // 3. Loading line animation controller
  late AnimationController _loadingController;
  late Animation<double> _loadingAnimation;

  Timer? _navTimer;

  final List<String> _letters = ['P', 'a', 'y', 'Z', 'e', 'n'];

  @override
  void initState() {
    super.initState();

    // Transparent system overlays for an edge-to-edge immersive look
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    // Entrance Animation (2200ms for staggered letter reveal)
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _bgFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
    );

    _logoScale = Tween<double>(begin: 0.70, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.10, 0.45, curve: Curves.easeOutBack),
      ),
    );

    _logoFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.10, 0.40, curve: Curves.easeIn),
    );

    // Subtitles slide & fade after letters complete (around 0.65 to 0.88)
    _subtitlesSlide = Tween<double>(begin: 18.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.65, 0.88, curve: Curves.easeOutCubic),
      ),
    );

    _subtitlesFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.65, 0.85, curve: Curves.easeIn),
    );

    _bottomFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.75, 1.0, curve: Curves.easeIn),
    );

    _entranceController.forward();

    // Floating Physics for 3D Logo (2600ms ping-pong, no glow aura)
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );

    // Loading line progress animation (4200ms slow, smooth continuous pace)
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..repeat();

    _loadingAnimation = CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeInOutSine,
    );

    // Navigate to Onboarding screen after splash animation completes
    _navTimer = Timer(const Duration(milliseconds: 4000), () {
      if (mounted) {
        Get.offNamed(AppRoutes.first);
      }
    });
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    _entranceController.dispose();
    _floatController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final compact = size.height < 700;

    return Scaffold(
      backgroundColor: const Color(0xFF03141F),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // -----------------------------------------------------------------
          // 1. High-Resolution Clean Curved Wave Background Image
          // -----------------------------------------------------------------
          FadeTransition(
            opacity: _bgFade,
            child: Image.asset(
              'assets/images/splash_bg.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
            ),
          ),

          // -----------------------------------------------------------------
          // 2. Foreground Elements: Logo, Letter-by-Letter Title, Subtitles
          // -----------------------------------------------------------------
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: size.height * (compact ? 0.08 : 0.16)),

                // Animated 3D Floating Logo (Clean, No Glowing Aura)
                AnimatedBuilder(
                  animation: _floatController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _floatAnimation.value),
                      child: FadeTransition(
                        opacity: _logoFade,
                        child: ScaleTransition(
                          scale: _logoScale,
                          child: Image.asset(
                            'assets/images/payzen_logo.png',
                            width: compact ? 96 : 112,
                            height: compact ? 112 : 130,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: compact ? 14 : 22),

                // -------------------------------------------------------------
                // One-by-One Staggered Animated "PayZen" Brand Name
                // (Clean, No Glowing Shadow on ZEN)
                // -------------------------------------------------------------
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(_letters.length, (index) {
                    final char = _letters[index];
                    final isZen = index >= 3;
                    final letterColor =
                        isZen ? const Color(0xFF19C6AE) : Colors.white;

                    // Stagger each letter's entrance interval
                    final start = 0.35 + (index * 0.050);
                    final end = math.min(1.0, start + 0.16);

                    final letterCurve = CurvedAnimation(
                      parent: _entranceController,
                      curve: Interval(start, end, curve: Curves.easeOutBack),
                    );

                    final letterFade = CurvedAnimation(
                      parent: _entranceController,
                      curve: Interval(
                        start,
                        math.min(1.0, start + 0.12),
                        curve: Curves.easeIn,
                      ),
                    );

                    return AnimatedBuilder(
                      animation: _entranceController,
                      builder: (context, child) {
                        final val = letterCurve.value;
                        return Opacity(
                          opacity: letterFade.value.clamp(0.0, 1.0),
                          child: Transform.translate(
                            offset: Offset(0, 18 * (1.0 - val)),
                            child: Transform.scale(
                              scale: 0.65 + (0.35 * val),
                              child: Text(
                                char,
                                style: GoogleFonts.inter(
                                  fontSize: compact ? 36 : 44,
                                  fontWeight: FontWeight.w800,
                                  color: letterColor,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),

                SizedBox(height: compact ? 6 : 10),

                // Subtitles: PAY • SAVE • GROW / TOGETHER
                AnimatedBuilder(
                  animation: _entranceController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _subtitlesSlide.value),
                      child: FadeTransition(
                        opacity: _subtitlesFade,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // PAY • SAVE • GROW
                            Text(
                              'P A Y   •   S A V E   •   G R O W',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFE6F8F6),
                                letterSpacing: 3.0,
                              ),
                            ),

                            const SizedBox(height: 6),

                            // TOGETHER
                            Text(
                              'T O G E T H E R',
                              style: GoogleFonts.inter(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF7ECEC5),
                                letterSpacing: 6.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const Spacer(),

                // -------------------------------------------------------------
                // 3. Bottom Section: Tagline & Loading Line
                // -------------------------------------------------------------
                FadeTransition(
                  opacity: _bottomFade,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Subtitle: Secure UPI Payments for a Smarter Tomorrow
                      Text(
                        'Secure UPI Payments for a',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFB5D3E2),
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Smarter Tomorrow',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Animated Loading Line (low width, smooth & compact)
                      AnimatedBuilder(
                        animation: _loadingAnimation,
                        builder: (context, child) {
                          final progress = _loadingAnimation.value;
                          const barWidth = 84.0;
                          const barHeight = 3.5;

                          return Container(
                            width: barWidth,
                            height: barHeight,
                            decoration: BoxDecoration(
                              color: const Color(0xFF09293B),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                // Progress Fill
                                Container(
                                  width: barWidth * progress,
                                  height: barHeight,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF007A87),
                                        Color(0xFF19C6AE),
                                        Color(0xFF53FFF0),
                                      ],
                                    ),
                                  ),
                                ),

                                // Leading Edge Dot
                                if (progress > 0.05)
                                  Positioned(
                                    left: (barWidth * progress) - 3.5,
                                    top: -1.25,
                                    child: Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),

                      SizedBox(
                        height: math.max(
                          compact ? 24.0 : 48.0,
                          size.height * (compact ? 0.04 : 0.065),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
