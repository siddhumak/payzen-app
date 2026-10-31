import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/app_gradients.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isBalanceVisible = true;
  late final PageController _bannerController;
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;

  final List<String> _bannerImages = const [
    'assets/images/banner_cashback.png',
    'assets/images/banner_recharge.png',
    'assets/images/banner_refer.png',
  ];

  @override
  void initState() {
    super.initState();
    _bannerController = PageController();
    _startBannerAutoScroll();
  }

  void _startBannerAutoScroll() {
    _bannerTimer?.cancel();
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;
      if (_bannerController.hasClients) {
        final nextIndex = (_currentBannerIndex + 1) % _bannerImages.length;
        _bannerController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // =============================================================
              // 1. Dark Branded Header with User's Wave Background Artwork
              // =============================================================
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF041420),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/dashboard_header_wave_bg.jpg',
                    ),
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -54,
                      child: Container(
                        height: 110,
                        decoration: const BoxDecoration(
                          color: AppColors.warmIvory,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),

                            // Top Bar: PayZen Logo + Brand Name + Bell + Profile Avatar
                            Row(
                              children: [
                                // PayZen Logo Icon
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: AppGradients.logoAccent,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/payzen_logo.png',
                                      width: 22,
                                      height: 22,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (_, __, ___) => const Icon(
                                            LucideIcons.zap,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),

                                // Brand Name
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Pay',
                                        style: GoogleFonts.inter(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Zen',
                                        style: GoogleFonts.inter(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Spacer(),

                                // Notification Bell with Unread Mint Badge
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.08),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          LucideIcons.bell,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 9,
                                      top: 8,
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: AppColors.electricMint,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFF061C2B),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(width: 12),

                                // User Profile Avatar (Siddhesh)
                                GestureDetector(
                                  onTap: () => Get.toNamed(AppRoutes.profile),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.35),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/user_avatar.png',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (_, __, ___) => Container(
                                              color: AppColors.deepTeal,
                                              child: const Center(
                                                child: Icon(
                                                  LucideIcons.user,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 11),

                            // Greeting Block
                            Text(
                              'Good evening,',
                              style: GoogleFonts.inter(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFA5C1CD),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  'Siddhesh',
                                  style: GoogleFonts.inter(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '👋',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Simple. Secure. Together.',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7FA7B6),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Total Balance Card
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 14.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0C222E),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: const Color(0xFF7DE2D0),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.42),
                                    blurRadius: 22,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Total Balance + Info Icon
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Balance',
                                        style: GoogleFonts.inter(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF8FAAB8),
                                        ),
                                      ),
                                      const Icon(
                                        LucideIcons.info,
                                        size: 18,
                                        color: Color(0xFF8FAAB8),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  // Amount + Eye Visibility Toggle
                                  Row(
                                    children: [
                                      Text(
                                        _isBalanceVisible
                                            ? '₹ 24,580.00'
                                            : '₹ ••••••••',
                                        style: GoogleFonts.inter(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isBalanceVisible =
                                                !_isBalanceVisible;
                                          });
                                        },
                                        behavior: HitTestBehavior.opaque,
                                        child: Icon(
                                          _isBalanceVisible
                                              ? LucideIcons.eye
                                              : LucideIcons.eyeOff,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  // Subtle Card Divider
                                  Container(
                                    height: 1.0,
                                    color: Colors.white.withOpacity(0.08),
                                  ),

                                  const SizedBox(height: 8),

                                  // Bank Account Selector Row
                                  Row(
                                    children: [
                                      const Icon(
                                        LucideIcons.landmark,
                                        size: 16,
                                        color: Color(0xFFA5C3CF),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'HDFC Bank •••• 1234',
                                        style: GoogleFonts.inter(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFA5C3CF),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        LucideIcons.chevronRight,
                                        size: 17,
                                        color: Color(0xFFA5C3CF),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =============================================================
              // 2. Warm Ivory Body Content Sheet
              // =============================================================
              Transform.translate(
                offset: const Offset(0, -54),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 50.0, 18.0, 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.pureWhite,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x08061C2B),
                              blurRadius: 12,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Quick Actions
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildQuickActionButton(
                                  icon: LucideIcons.scan,
                                  label: 'Scan & Pay',
                                  isSpecial: true,
                                  onTap: () => Get.toNamed(AppRoutes.scanner),
                                ),
                                _buildQuickActionButton(
                                  icon: LucideIcons.send,
                                  label: 'Send Money',
                                  onTap: () => Get.toNamed(AppRoutes.toMobile),
                                ),
                                _buildQuickActionButton(
                                  icon: LucideIcons.download,
                                  label: 'Receive',
                                  onTap: () => Get.toNamed(AppRoutes.qr),
                                ),
                                _buildQuickActionButton(
                                  icon: LucideIcons.landmark,
                                  label: 'Bank Transfer',
                                  onTap: () => Get.toNamed(AppRoutes.toBank),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Recharge & Bill Services
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildServiceButton(
                                  icon: LucideIcons.smartphone,
                                  label: 'Mobile\nRecharge',
                                  onTap:
                                      () =>
                                          Get.toNamed(AppRoutes.mobilerecharge),
                                ),
                                _buildServiceButton(
                                  icon: LucideIcons.receipt,
                                  label: 'Bill\nPayments',
                                  onTap: () => Get.toNamed(AppRoutes.billlist),
                                ),
                                _buildServiceButton(
                                  icon: LucideIcons.satellite,
                                  label: 'DTH',
                                  onTap: () {},
                                ),
                                _buildServiceButton(
                                  icon: LucideIcons.moreHorizontal,
                                  label: 'More',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Scrollable Promotional Banner Carousel
                      AspectRatio(
                        aspectRatio:
                            1024 / 280, // Consistent ~3.65:1 card ratio
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: PageView.builder(
                              controller: _bannerController,
                              itemCount: _bannerImages.length,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentBannerIndex = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (index == 0) {
                                      // Cashback offer
                                    } else if (index == 1) {
                                      Get.toNamed(AppRoutes.mobilerecharge);
                                    } else if (index == 2) {
                                      // Refer & earn
                                    }
                                  },
                                  child: Image.asset(
                                    _bannerImages[index],
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Synchronized Carousel Pagination Indicators (3 Dots)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_bannerImages.length, (i) {
                          final isActive = i == _currentBannerIndex;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: isActive ? 18 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color:
                                  isActive
                                      ? AppColors.electricMint
                                      : const Color(0xFFD2DCE2),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 24),

                      // Recent Transactions Section Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Transactions',
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: AppColors.deepNavyText,
                              letterSpacing: -0.3,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            behavior: HitTestBehavior.opaque,
                            child: Text(
                              'View All',
                              style: GoogleFonts.inter(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF009384),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Recent Transaction Tile (Rahul Sharma)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.pureWhite,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFE8EEF2),
                            width: 1.0,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x06061C2B),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Mint circle with Deep Teal Up-Right Arrow
                            Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF86E5D3),
                              ),
                              child: const Center(
                                child: Icon(
                                  LucideIcons.arrowUpRight,
                                  size: 21,
                                  color: Color(0xFF003D46),
                                ),
                              ),
                            ),

                            const SizedBox(width: 14),

                            // Name & Timestamp
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rahul Sharma',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.deepNavyText,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Paid • 15 Oct, 10:30 AM',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.mutedSlate,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 8),

                            // Amount
                            Text(
                              '- ₹1,000',
                              style: GoogleFonts.inter(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.deepNavyText,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Quick Action Button (Row 1)
  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isSpecial = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color:
                    isSpecial
                        ? const Color(0xFFCEF4EC) // Light mint for Scan & Pay
                        : null,
                gradient: isSpecial ? null : AppGradients.primaryCTA,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color:
                        isSpecial
                            ? const Color(0x2519C6AE)
                            : AppColors.deepTeal.withOpacity(0.20),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 23,
                  color:
                      isSpecial
                          ? AppColors.deepTeal
                          : Colors
                              .white, // Crisp white icons for Send, Receive, Bank Transfer
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepNavyText,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Service Button (Row 2)
  Widget _buildServiceButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Icon(icon, size: 23, color: AppColors.deepNavyText),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.deepNavyText,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
