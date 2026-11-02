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

                            const SizedBox(height: 14),

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

                            const SizedBox(height: 14),

                            // Total Balance Card (Overlapping Card)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 16.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0C222E),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: const Color(
                                    0xFF1D5A6E,
                                  ), // Glowing cyan border
                                  width: 1.2,
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

                                  const SizedBox(height: 12),

                                  // Subtle Card Divider
                                  Container(
                                    height: 1.0,
                                    color: Colors.white.withOpacity(0.08),
                                  ),

                                  const SizedBox(height: 12),

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
              // 2. Warm Ivory Body Content Sheet (Overlaps upward by 54px)
              // =============================================================
              Transform.translate(
                offset: const Offset(0, -54),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 50.0, 18.0, 36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Get.toNamed(AppRoutes.addbank),
                          borderRadius: BorderRadius.circular(20),
                          child: Ink(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.deepTeal, Color(0xFF087E78)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.cardShadow,
                                  blurRadius: 14,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 46,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.13),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Icon(
                                    LucideIcons.landmark,
                                    color: AppColors.electricMint,
                                    size: 23,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Link your bank account',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Set up UPI and start making payments',
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFFD4E9E8),
                                          fontSize: 12,
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  LucideIcons.arrowRight,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Quick Actions & Services Floating Card
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.pureWhite,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: const Color(0xFFE8EEF2),
                            width: 1.0,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x08061C2B),
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Quick Actions (Row 1)
                            Row(
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
                                  onTap: () => Get.toNamed(AppRoutes.addbank),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Recharge & Bills Services (Row 2)
                            Row(
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
                                  icon: LucideIcons.wallet,
                                  label: 'Wallet',
                                  onTap: () => Get.toNamed(AppRoutes.wallet),
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

                      const SizedBox(height: 16),

                      // PayZen Wallet activation prompt
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Get.toNamed(AppRoutes.walletActivation),
                          borderRadius: BorderRadius.circular(18),
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.pureWhite,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(0xFFDCEFEA),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x08061C2B),
                                  blurRadius: 12,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(13),
                                  child: Image.asset(
                                    'assets/images/payzen_wallet_art.png',
                                    width: 44,
                                    height: 44,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'PayZen Wallet',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.deepNavyText,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Activate your bank wallet to add money and pay easily.',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          height: 1.3,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.deepNavyText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: AppGradients.primaryCTA,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 9,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Activate',
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(
                                          LucideIcons.arrowRight,
                                          size: 13,
                                          color: Colors.white,
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

                      const SizedBox(height: 16),

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
                            child: Row(
                              children: [
                                Text(
                                  'View All',
                                  style: GoogleFonts.inter(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF009384),
                                  ),
                                ),
                                const SizedBox(width: 3),
                                const Icon(
                                  LucideIcons.chevronRight,
                                  size: 15,
                                  color: Color(0xFF009384),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Recent Transactions Card (Multi-item Activity Card)
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.pureWhite,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFE8EEF2),
                            width: 1.0,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x06061C2B),
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // 1. Rahul Sharma
                            _buildActivityTile(
                              icon: LucideIcons.arrowUpRight,
                              iconColor: const Color(0xFF003D46),
                              iconBg: const Color(0xFF86E5D3),
                              title: 'Rahul Sharma',
                              subtitle: 'Paid',
                              amount: '- ₹1,000',
                              timestamp: '15 Oct, 10:30 AM',
                            ),
                            const Divider(
                              height: 1,
                              indent: 64,
                              color: Color(0xFFF0F4F7),
                            ),

                            // 2. Electricity Bill
                            _buildActivityTile(
                              imageAsset:
                                  'assets/images/icon_3d_electricity.png',
                              icon: LucideIcons.zap,
                              iconColor: const Color(0xFFF59E0B),
                              iconBg: const Color(0xFFFEF3C7),
                              title: 'Electricity Bill',
                              subtitle: 'MSEDCL • Paid',
                              amount: '₹1,240.00',
                              timestamp: 'Today, 11:26 AM',
                            ),
                            const Divider(
                              height: 1,
                              indent: 64,
                              color: Color(0xFFF0F4F7),
                            ),

                            // 3. Mobile Recharge
                            _buildActivityTile(
                              imageAsset: 'assets/images/icon_3d_mobile.png',
                              icon: LucideIcons.smartphone,
                              iconColor: const Color(0xFF3B82F6),
                              iconBg: const Color(0xFFEFF6FF),
                              title: 'Mobile Recharge',
                              subtitle: 'Jio • ₹349 • Paid',
                              amount: '₹349.00',
                              timestamp: 'Yesterday, 06:18 PM',
                            ),
                            const Divider(
                              height: 1,
                              indent: 64,
                              color: Color(0xFFF0F4F7),
                            ),

                            // 4. UPI Payment to Rohit Patil
                            _buildActivityTile(
                              imageAsset:
                                  'assets/images/icon_3d_send_plane.png',
                              icon: LucideIcons.send,
                              iconColor: const Color(0xFF0D9488),
                              iconBg: const Color(0xFFE6F9F5),
                              title: 'UPI Payment',
                              subtitle: 'to Rohit Patil',
                              amount: '₹500.00',
                              timestamp: 'Yesterday, 02:07 PM',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // =====================================================
                      // 3. Recharge & Bills Section (8 Items Grid)
                      // =====================================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recharge & Bills',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.deepNavyText,
                              letterSpacing: -0.3,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.billlist),
                            behavior: HitTestBehavior.opaque,
                            child: Row(
                              children: [
                                Text(
                                  'View All',
                                  style: GoogleFonts.inter(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF009384),
                                  ),
                                ),
                                const SizedBox(width: 3),
                                const Icon(
                                  LucideIcons.chevronRight,
                                  size: 15,
                                  color: Color(0xFF009384),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Row 1 of Recharge & Bills
                      Row(
                        children: [
                          _buildCardServiceTile(
                            imageAsset: 'assets/images/icon_3d_mobile.png',
                            fallbackIcon: LucideIcons.smartphone,
                            iconColor: const Color(0xFF3B82F6),
                            label: 'Mobile\nRecharge',
                            onTap: () => Get.toNamed(AppRoutes.mobilerecharge),
                          ),
                          const SizedBox(width: 10),
                          _buildCardServiceTile(
                            imageAsset: 'assets/images/icon_3d_electricity.png',
                            fallbackIcon: LucideIcons.zap,
                            iconColor: const Color(0xFFF59E0B),
                            label: 'Electricity',
                            onTap: () => Get.toNamed(AppRoutes.billlist),
                          ),
                          const SizedBox(width: 10),
                          _buildCardServiceTile(
                            imageAsset: 'assets/images/payzen_wallet_art.png',
                            fallbackIcon: LucideIcons.wallet,
                            iconColor: AppColors.deepTeal,
                            label: 'Wallet',
                            onTap: () => Get.toNamed(AppRoutes.wallet),
                          ),
                          const SizedBox(width: 10),
                          _buildCardServiceTile(
                            imageAsset: 'assets/images/icon_3d_fastag.png',
                            fallbackIcon: LucideIcons.creditCard,
                            iconColor: const Color(0xFF10B981),
                            label: 'FASTag',
                            onTap: () {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Row 2 of Recharge & Bills
                      Row(
                        children: [
                          _buildCardServiceTile(
                            imageAsset: 'assets/images/icon_3d_rent.png',
                            fallbackIcon: LucideIcons.home,
                            iconColor: const Color(0xFF8B5CF6),
                            label: 'Rent',
                            onTap: () {},
                          ),
                          const SizedBox(width: 10),
                          _buildCardServiceTile(
                            imageAsset: 'assets/images/icon_3d_credit_card.png',
                            fallbackIcon: LucideIcons.creditCard,
                            iconColor: const Color(0xFF2563EB),
                            label: 'Credit Card',
                            onTap: () {},
                          ),
                          const SizedBox(width: 10),
                          _buildCardServiceTile(
                            imageAsset: 'assets/images/icon_3d_loan.png',
                            fallbackIcon: LucideIcons.banknote,
                            iconColor: const Color(0xFF0284C7),
                            label: 'Loan\nRepayment',
                            onTap: () {},
                          ),
                          const SizedBox(width: 10),
                          _buildCardServiceTile(
                            imageAsset: 'assets/images/icon_3d_more.png',
                            fallbackIcon: LucideIcons.moreHorizontal,
                            iconColor: AppColors.deepNavyText,
                            label: 'More',
                            onTap: () {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      // -----------------------------------------------------
                      // Banner: "Pay bills on time. Stay in control."
                      // -----------------------------------------------------
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.billlist),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x08061C2B),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: AspectRatio(
                              aspectRatio:
                                  1024 /
                                  280, // Consistent ~3.65:1 ratio matching promo banners
                              child: Image.asset(
                                'assets/images/banner_pay_bills.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // =====================================================
                      // 4. Travel & Transit Section (4 Items Row)
                      // =====================================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Travel & Transit',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.deepNavyText,
                              letterSpacing: -0.3,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            behavior: HitTestBehavior.opaque,
                            child: Row(
                              children: [
                                Text(
                                  'View All',
                                  style: GoogleFonts.inter(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF009384),
                                  ),
                                ),
                                const SizedBox(width: 3),
                                const Icon(
                                  LucideIcons.chevronRight,
                                  size: 15,
                                  color: Color(0xFF009384),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // 4 Transit Items (Rich Visual Cards Matching Reference)
                      Row(
                        children: [
                          _buildTravelCard(
                            imageAsset: 'assets/images/card_travel_flights.png',
                            onTap: () {},
                          ),
                          const SizedBox(width: 8),
                          _buildTravelCard(
                            imageAsset: 'assets/images/card_travel_bus.png',
                            onTap: () {},
                          ),
                          const SizedBox(width: 8),
                          _buildTravelCard(
                            imageAsset: 'assets/images/card_travel_train.png',
                            onTap: () {},
                          ),
                          const SizedBox(width: 8),
                          _buildTravelCard(
                            imageAsset: 'assets/images/card_travel_hotels.png',
                            onTap: () {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      // -----------------------------------------------------
                      // Banner: "Save on your next trip"
                      // -----------------------------------------------------
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2F6F4),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x08061C2B),
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: AspectRatio(
                            aspectRatio: 1024 / 280,
                            child: Image.asset(
                              'assets/images/Travel Savings Banner with Airplane Illustration.png',
                              width: double.infinity,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              errorBuilder:
                                  (context, error, stackTrace) => Center(
                                    child: Text(
                                      'Save on your next trip',
                                      style: GoogleFonts.inter(
                                        color: AppColors.deepNavyText,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // =====================================================
                      // 5. Offers & Rewards Section (2 Side-by-Side Cards)
                      // =====================================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Offers & Rewards',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.deepNavyText,
                              letterSpacing: -0.3,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            behavior: HitTestBehavior.opaque,
                            child: Row(
                              children: [
                                Text(
                                  'View All',
                                  style: GoogleFonts.inter(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF009384),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  LucideIcons.arrowRight,
                                  size: 14,
                                  color: Color(0xFF009384),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // 2 Cards Side-by-Side
                      Row(
                        children: [
                          // Card 1: Cashback on everyday payments
                          Expanded(
                            child: Container(
                              height: 110,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEBF7F4),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: const Color(0xFFD6EFEA),
                                  width: 1.0,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cashback on\neveryday payments',
                                        style: GoogleFonts.inter(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.deepNavyText,
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Get discounts and\ncashback on recharges...',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.mutedSlate,
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: -2,
                                    bottom: -2,
                                    child: Image.asset(
                                      'assets/images/hero_gift_coin.png',
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (_, __, ___) => const SizedBox(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Card 2: Discover rewards for you
                          Expanded(
                            child: Container(
                              height: 110,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAF7EE),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: const Color(0xFFEDE4D2),
                                  width: 1.0,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Discover\nrewards for you',
                                        style: GoogleFonts.inter(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.deepNavyText,
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Exclusive offers,\nvouchers & deals.',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.mutedSlate,
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: -2,
                                    bottom: -2,
                                    child: Image.asset(
                                      'assets/images/hero_coupon.png',
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (_, __, ___) => const SizedBox(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // =====================================================
                      // 6. Financial Services Section (4 Tiles)
                      // =====================================================
                      Text(
                        'Financial Services',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.deepNavyText,
                          letterSpacing: -0.3,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Financial Service List Tiles
                      _buildFinancialTile(
                        iconAsset: 'assets/images/ico_credit_score.png',
                        title: 'Credit Score',
                        subtitle: 'Check and monitor your credit score',
                        fallbackIcon: LucideIcons.gauge,
                        fallbackColor: const Color(0xFF0D9488),
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      _buildFinancialTile(
                        iconAsset: 'assets/images/ico_digital_gold.png',
                        title: 'Digital Gold',
                        subtitle: 'Buy and manage digital gold',
                        fallbackIcon: LucideIcons.coins,
                        fallbackColor: const Color(0xFFEAB308),
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      _buildFinancialTile(
                        iconAsset: 'assets/images/ico_insurance.png',
                        title: 'Insurance',
                        subtitle: 'Explore insurance for you and your family',
                        fallbackIcon: LucideIcons.shieldCheck,
                        fallbackColor: const Color(0xFF3B82F6),
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      _buildFinancialTile(
                        iconAsset: 'assets/images/ico_personal_loans.png',
                        title: 'Personal Loans',
                        subtitle: 'Explore loan options for your needs',
                        fallbackIcon: LucideIcons.banknote,
                        fallbackColor: const Color(0xFF10B981),
                        onTap: () {},
                      ),

                      const SizedBox(height: 40),
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
                        : AppColors.deepTeal, // Deep teal for others (#003D46)
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

  // Activity Tile for Recent Activity Card
  Widget _buildActivityTile({
    String? imageAsset,
    IconData? icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required String amount,
    required String timestamp,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      child: Row(
        children: [
          // Circular Icon Badge
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(shape: BoxShape.circle, color: iconBg),
            child: Center(
              child:
                  imageAsset != null
                      ? Image.asset(
                        imageAsset,
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                        errorBuilder:
                            (_, __, ___) => Icon(
                              icon ?? LucideIcons.zap,
                              size: 20,
                              color: iconColor,
                            ),
                      )
                      : Icon(
                        icon ?? LucideIcons.zap,
                        size: 20,
                        color: iconColor,
                      ),
            ),
          ),
          const SizedBox(width: 14),

          // Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.deepNavyText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
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

          // Amount & Timestamp + Chevron
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    amount,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.deepNavyText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    timestamp,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.mutedSlate,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 6),
              const Icon(
                LucideIcons.chevronRight,
                size: 16,
                color: Color(0xFF8FAAB8),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Card Service Tile for Recharge & Transit Grids (Full Card enclosing Icon + Label)
  Widget _buildCardServiceTile({
    String? imageAsset,
    IconData? fallbackIcon,
    Color? iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 96,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE8EEF2), width: 1.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x06061C2B),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (imageAsset != null)
                Image.asset(
                  imageAsset,
                  width: 34,
                  height: 34,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (_, __, ___) => Icon(
                        fallbackIcon ?? LucideIcons.sparkles,
                        size: 26,
                        color: iconColor ?? AppColors.deepTeal,
                      ),
                )
              else
                Icon(
                  fallbackIcon ?? LucideIcons.sparkles,
                  size: 26,
                  color: iconColor ?? AppColors.deepTeal,
                ),
              const SizedBox(height: 7),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.deepNavyText,
                  height: 1.15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Travel & Transit Rich Visual Card
  Widget _buildTravelCard({
    required String imageAsset,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE8EEF2), width: 1.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x06061C2B),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AspectRatio(
              aspectRatio:
                  0.90, // Generous responsive vertical ratio (~88-94px)
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Financial Services List Tile
  Widget _buildFinancialTile({
    required String iconAsset,
    required String title,
    required String subtitle,
    required IconData fallbackIcon,
    required Color fallbackColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8EEF2), width: 1.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x05061C2B),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            SizedBox(
              width: 38,
              height: 38,
              child: Center(
                child: Image.asset(
                  iconAsset,
                  width: 36,
                  height: 36,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (_, __, ___) =>
                          Icon(fallbackIcon, size: 24, color: fallbackColor),
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepNavyText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w400,
                      color: AppColors.mutedSlate,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              LucideIcons.chevronRight,
              size: 18,
              color: Color(0xFF8FAAB8),
            ),
          ],
        ),
      ),
    );
  }
}
