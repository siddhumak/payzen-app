import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payzen_app/screens/Scanner/scanner_screen.dart';
import 'package:payzen_app/screens/dashboard/dashboard_screen.dart';
import 'package:payzen_app/screens/main/controller/main_controller.dart';
import 'package:payzen_app/screens/mycards/mycard_screen.dart';
import 'package:payzen_app/screens/wallet/wallet_screen.dart';
import 'package:payzen_app/utils/bottom_navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainController controller = Get.find<MainController>();

  final List<Widget> _pages = const [
    DashboardScreen(),
    WalletScreen(),
    ScannerScreen(),
    MycardsScreen(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder:
              (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
          child: KeyedSubtree(
            key: ValueKey<int>(controller.currentIndex.value),
            child: _pages[controller.currentIndex.value],
          ),
        ),
        bottomNavigationBar: GradientBottomNavBarPageView(
          currentIndex: controller.currentIndex.value,
          onTabChanged: controller.changeTab,
        ),
      ),
    );
  }
}
