import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';

class FirstTimeMainScreen extends StatefulWidget {
  const FirstTimeMainScreen({super.key});

  @override
  State<FirstTimeMainScreen> createState() => _FirstTimeMainScreenState();
}

class _FirstTimeMainScreenState extends State<FirstTimeMainScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Gentle floating animation for the 3D illustration
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  final List<_OnboardingItem> _pages = [
    const _OnboardingItem(
      titlePart1: 'Fast, Secure\n& Simple ',
      titleAccent: 'Payments',
      subtitle: 'Send money, pay bills, recharge\nand more — all in one app.',
      imagePath: 'assets/images/onboarding_hero_1.png',
    ),
    const _OnboardingItem(
      titlePart1: 'Recharge, Pay Bills\n& Manage ',
      titleAccent: 'Everyday Needs',
      subtitle: 'Mobile, Electricity, DTH, FASTag,\nRent, Credit Cards and more.',
      imagePath: 'assets/images/onboarding_hero_2.png',
    ),
    const _OnboardingItem(
      titlePart1: 'Exciting Offers,\n',
      titleAccent: 'Rewards & More',
      subtitle: 'Get cashback, exclusive deals,\nvouchers and partner offers.',
      imagePath: 'assets/images/onboarding_hero_3.png',
    ),
  ];

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

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Get.offNamed(AppRoutes.loginselect);
    }
  }

  void _onSkipPressed() {
    Get.offNamed(AppRoutes.loginselect);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      body: SafeArea(
        child: Column(
          children: [
            // ---------------------------------------------------------------
            // 1. Top Bar: Skip Button
            // ---------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: _onSkipPressed,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.deepNavyText,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ---------------------------------------------------------------
            // 2. PageView Content (Titles & Hero Illustration)
            // ---------------------------------------------------------------
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = _pages[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.015),

                        // Title with Accent colored keyword
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              height: 1.25,
                              color: AppColors.deepNavyText,
                              letterSpacing: -0.4,
                            ),
                            children: [
                              TextSpan(text: item.titlePart1),
                              TextSpan(
                                text: item.titleAccent,
                                style: const TextStyle(
                                  color: AppColors.electricMint,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Subtitle
                        Text(
                          item.subtitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mutedSlate,
                            height: 1.4,
                          ),
                        ),

                        const Spacer(),

                        // 3D Hero Illustration with Gentle Hover
                        AnimatedBuilder(
                          animation: _floatController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _floatAnimation.value),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxHeight: size.height * 0.44,
                                ),
                                child: Image.asset(
                                  item.imagePath,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          },
                        ),

                        const Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ---------------------------------------------------------------
            // 3. Page Indicator Dots (Electric Mint Pill + Soft Grey Dots)
            // ---------------------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) {
                  final isActive = _currentPage == index;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: isActive ? 22.0 : 7.0,
                    height: 7.0,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.electricMint
                          : const Color(0xFFDCE2E7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: size.height * 0.035),

            // ---------------------------------------------------------------
            // 4. Bottom Full-Width Pill CTA Button: "Next ->" / "Get Started ->"
            // ---------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onNextPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepTeal, // #003D46
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        _currentPage == _pages.length - 1
                            ? 'Get Started'
                            : 'Next',
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
                        size: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: size.height * 0.025),
          ],
        ),
      ),
    );
  }
}

class _OnboardingItem {
  final String titlePart1;
  final String titleAccent;
  final String subtitle;
  final String imagePath;

  const _OnboardingItem({
    required this.titlePart1,
    required this.titleAccent,
    required this.subtitle,
    required this.imagePath,
  });
}
