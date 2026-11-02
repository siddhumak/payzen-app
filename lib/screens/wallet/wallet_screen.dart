import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.warmIvory,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF012C37),
        body: Column(
          children: [
            // Dark Teal Header Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF012C37),
                    Color(0xFF003D4C),
                    Color(0xFF004959),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/header_waves_bg.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  opacity: 0.35,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                  child: Column(
                    children: [
                      // Top Navigation Bar
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (Get.key.currentState?.canPop() ?? false) {
                                Get.back();
                              } else {
                                Get.offAllNamed(AppRoutes.main);
                              }
                            },
                            icon: const Icon(
                              LucideIcons.arrowLeft,
                              color: Colors.white,
                              size: 22,
                            ),
                            tooltip: 'Back',
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'PayZen Wallet',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              LucideIcons.moreVertical,
                              color: Colors.white,
                              size: 20,
                            ),
                            tooltip: 'More options',
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // 3D Wallet + Balance Row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/wallet_3d_clean.png',
                              width: 108,
                              height: 94,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Image.asset(
                                'assets/images/wallet_3d_icon.png',
                                width: 108,
                                height: 94,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Wallet Balance',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFC7EBE6),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '₹ 2,000.00',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 29,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),

            // White Bottom Sheet filling remainder of screen edge-to-edge
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.warmIvory,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 16,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(18, 22, 18, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Quick Action Buttons Row: Add Money | Send | Withdraw
                        const _QuickActionsRow(),
                        const SizedBox(height: 18),

                        // Wallet Limits Banner
                        const _WalletLimitsBanner(),
                        const SizedBox(height: 22),

                        // Recent Transactions Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Transactions',
                              style: GoogleFonts.inter(
                                color: AppColors.deepNavyText,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              behavior: HitTestBehavior.opaque,
                              child: Text(
                                'View All',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF009384),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Transactions List
                        const _TransactionTile(
                          imageAsset: 'assets/images/txn_wallet.png',
                          title: 'Added to Wallet',
                          subtitle: 'From HDFC Bank •••• 1234',
                          amount: '+ ₹1,000',
                          time: 'Today, 10:24 AM',
                          positive: true,
                        ),
                        const Divider(
                          height: 24,
                          thickness: 1,
                          color: Color(0xFFE5E7EB),
                        ),
                        const _TransactionTile(
                          imageAsset: 'assets/images/txn_amazon.png',
                          title: 'Paid to Amazon',
                          subtitle: 'Wallet Payment',
                          amount: '- ₹499',
                          time: 'Yesterday, 08:16 PM',
                          positive: false,
                        ),
                        const Divider(
                          height: 24,
                          thickness: 1,
                          color: Color(0xFFE5E7EB),
                        ),
                        const _TransactionTile(
                          imageAsset: 'assets/images/txn_cashback.png',
                          title: 'Cashback Received',
                          subtitle: 'Wallet Cashback',
                          amount: '+ ₹25',
                          time: 'Yesterday, 06:02 PM',
                          positive: true,
                        ),
                        const Divider(
                          height: 24,
                          thickness: 1,
                          color: Color(0xFFE5E7EB),
                        ),
                        const _TransactionTile(
                          imageAsset: 'assets/images/txn_flipkart.png',
                          title: 'Paid to Flipkart',
                          subtitle: 'Wallet Payment',
                          amount: '- ₹1,299',
                          time: 'Monday, 07:42 PM',
                          positive: false,
                        ),
                        const Divider(
                          height: 24,
                          thickness: 1,
                          color: Color(0xFFE5E7EB),
                        ),
                        const _TransactionTile(
                          imageAsset: 'assets/images/txn_meesho.png',
                          title: 'Paid to Meesho',
                          subtitle: 'Wallet Payment',
                          amount: '- ₹799',
                          time: 'Monday, 06:18 PM',
                          positive: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. Add Money (Gradient primary button)
        Expanded(
          child: _ActionButton(
            label: 'Add Money',
            isPrimary: true,
            iconWidget: const Icon(
              LucideIcons.plus,
              color: Colors.white,
              size: 22,
            ),
            onTap: () => Get.toNamed(AppRoutes.walletAddMoney),
          ),
        ),
        const SizedBox(width: 10),

        // 2. Send (⇄ arrowLeftRight icon matching reference)
        Expanded(
          child: _ActionButton(
            label: 'Send',
            isPrimary: false,
            iconWidget: const Icon(
              LucideIcons.arrowLeftRight,
              color: AppColors.deepNavyText,
              size: 21,
            ),
            onTap: () {},
          ),
        ),
        const SizedBox(width: 10),

        // 3. Withdraw (Calendar with down arrow icon matching reference)
        Expanded(
          child: _ActionButton(
            label: 'Withdraw',
            isPrimary: false,
            iconWidget: Stack(
              alignment: Alignment.center,
              children: const [
                Icon(
                  LucideIcons.calendar,
                  color: AppColors.deepNavyText,
                  size: 21,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(
                    LucideIcons.arrowDown,
                    color: AppColors.deepNavyText,
                    size: 11,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.isPrimary,
    required this.iconWidget,
    required this.onTap,
  });

  final String label;
  final bool isPrimary;
  final Widget iconWidget;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      decoration: BoxDecoration(
        gradient: isPrimary
            ? const LinearGradient(
                colors: [
                  Color(0xFF00B092),
                  Color(0xFF007A65),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isPrimary ? null : AppColors.warmIvory,
        borderRadius: BorderRadius.circular(18),
        border: isPrimary
            ? null
            : Border.all(
                color: const Color(0xFFE8EEF0),
                width: 1.0,
              ),
        boxShadow: [
          BoxShadow(
            color: isPrimary
                ? const Color(0x30009384)
                : const Color(0x06061C2B),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconWidget,
              const SizedBox(height: 6),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: isPrimary ? Colors.white : AppColors.deepNavyText,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalletLimitsBanner extends StatelessWidget {
  const _WalletLimitsBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFF9ED),
            Color(0xFFF0FAF7),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        image: const DecorationImage(
          image: AssetImage('assets/images/wallet-sunlight.png'),
          fit: BoxFit.cover,
          alignment: Alignment.center,
          opacity: 0.22,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFFECC7),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06061C2B),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 8-Point Rosette/Star Golden Badge with ₹ Symbol
          SizedBox(
             width: 40,
             height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: 0.785398, // 45 degrees
                  child: Container(
                     width: 34,
                     height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
                Container(
                   width: 34,
                   height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                const Text(
                  '₹',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Titles
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wallet Limits',
                  style: GoogleFonts.inter(
                    color: AppColors.deepNavyText,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Upto ₹2,00,000 per month',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF64748B),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Trailing Chevron
          const Icon(
            LucideIcons.chevronRight,
            color: AppColors.deepNavyText,
            size: 18,
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({
    this.icon = LucideIcons.circle,
    this.imageAsset,
    this.iconColor = AppColors.deepTeal,
    this.iconBackground = const Color(0xFFE2F5EF),
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.time,
    required this.positive,
  });

  final IconData icon;
  final String? imageAsset;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final String amount;
  final String time;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: imageAsset != null
                ? Image.asset(
                    imageAsset!,
                    width: 44,
                    height: 44,
                    fit: BoxFit.contain,
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: iconBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: iconColor, size: 22),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: AppColors.deepNavyText,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF64748B),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: GoogleFonts.inter(
                  color: positive
                      ? const Color(0xFF168528)
                      : AppColors.deepNavyText,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: GoogleFonts.inter(
                  color: const Color(0xFF94A3B8),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
