import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2online_recharge_app/constant/colors.dart';
import 'package:m2online_recharge_app/screens/main/controller/main_controller.dart';

class CustomSideDrawer extends StatelessWidget {
  const CustomSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    final bool isTablet = screenWidth > 600;
    final double avatarRadius = isTablet ? 60 : 45;
    final double topHeight = screenHeight * 0.42;

    return Drawer(
      child: Stack(
        children: [
          // Background header
          Container(
            height: topHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/red_background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Blur overlay
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
                // Profile Info
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: Colors.white,
                        child: Text(
                          "SD",
                          style: TextStyle(
                            fontSize: isTablet ? 42 : 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Siddhesh Dhumak",
                        style: GoogleFonts.inter(
                          fontSize: isTablet ? 22 : 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "siddhesh@email.com",
                        style: GoogleFonts.inter(
                          fontSize: isTablet ? 16 : 13,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Drawer content
          Obx(
            () => Positioned.fill(
              top: topHeight - 30,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F8FF),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, -4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    vertical: isTablet ? 24 : 16,
                    horizontal: 12,
                  ),
                  children: [
                    ...List.generate(_drawerItems.length, (index) {
                      final item = _drawerItems[index];
                      final isSelected =
                          mainController.selectedTabIndex.value == index;
                      final tile = _buildStyledListTile(
                        icon: item.icon,
                        title: item.title,
                        bgColor: AppColors.primary,
                        isSelected: isSelected,
                        onTap: item.onTap ?? () {},
                      );

                      // Add divider only after every 3rd tile (i.e., after index 2, 5, 8...)
                      if ((index + 1) % 3 == 0 &&
                          index != _drawerItems.length - 1) {
                        return Column(
                          children: [tile, _buildGradientDivider()],
                        );
                      } else {
                        return tile;
                      }
                    }),

                    const Divider(height: 32),

                    // Logout Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Logout",
                          style: GoogleFonts.inter(
                            fontSize: isTablet ? 18 : 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledListTile({
    required IconData icon,
    required String title,
    required Color bgColor,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: bgColor, size: 20),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          if (isSelected)
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}

// Drawer items (refactored to keep code clean)
class DrawerItem {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  DrawerItem({required this.icon, required this.title, this.onTap});
}

final MainController mainController = Get.find<MainController>();

final List<DrawerItem> _drawerItems = [
  DrawerItem(
    icon: Icons.home,
    title: "Home",
    onTap: () {
      Get.back();
      mainController.changeTab(0);
    },
  ),
  DrawerItem(
    icon: Icons.account_balance_wallet,
    title: "Wallet",
    onTap: () {
      Get.back();
      mainController.changeTab(1); // Wallet tab index
    },
  ),
  DrawerItem(
    icon: Icons.qr_code_scanner,
    title: "Scan & Pay",
    onTap: () {
      mainController.changeTab(2);
    },
  ),
  DrawerItem(
    icon: Icons.receipt_long,
    title: "Bills & Utilities",
    onTap: () {},
  ),
  DrawerItem(
    icon: Icons.credit_card,
    title: "Credit Cards",
    onTap: () {
      mainController.changeTab(3);
    },
  ),
  DrawerItem(icon: Icons.local_offer, title: "Offers & Cashback", onTap: () {}),
  DrawerItem(
    icon: Icons.person,
    title: "Profile",
    onTap: () {
      Get.offNamed('/profile');
    },
  ),
  DrawerItem(icon: Icons.settings, title: "Settings", onTap: () {}),
  DrawerItem(icon: Icons.support_agent, title: "Support", onTap: () {}),
];

Widget _buildGradientDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [AppColors.primary, Colors.transparent],
      ),
    ),
  );
}
