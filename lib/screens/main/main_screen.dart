import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payzen_app/screens/Scanner/scanner_screen.dart';
import 'package:payzen_app/screens/dashboard/dashboard_screen.dart';
import 'package:payzen_app/screens/main/controller/main_controller.dart';
import 'package:payzen_app/screens/profile/profile_screen.dart';
import 'package:payzen_app/screens/wallet/wallet_screen.dart';
import 'package:payzen_app/utils/bottom_navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainController controller = Get.find<MainController>();
  late final PageController _pageController;

  final List<Widget> _pages = const [
    DashboardScreen(),
    WalletScreen(),
    ScannerScreen(),
    WalletScreen(), // Rewards / Offers placeholder
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: controller.currentIndex.value);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    controller.changeTab(index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        bottomNavigationBar: GradientBottomNavBarPageView(
          currentIndex: controller.currentIndex.value,
          onTabChanged: _onTabChanged,
        ),
      ),
    );
  }
}
