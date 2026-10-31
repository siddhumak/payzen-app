import 'package:flutter/material.dart';
import 'package:m2online_recharge_app/components/custom_appbar.dart';
import 'package:m2online_recharge_app/components/custom_drawer.dart';
import 'package:m2online_recharge_app/screens/dashboard/widgets/cashcheck_banner.dart';
import 'package:m2online_recharge_app/screens/dashboard/widgets/finance_service_section.dart';
import 'package:m2online_recharge_app/screens/dashboard/widgets/free_tools_section.dart';
import 'package:m2online_recharge_app/screens/dashboard/widgets/quick_links_section.dart';
import 'package:m2online_recharge_app/screens/dashboard/widgets/quick_tansfer.dart';
import 'package:m2online_recharge_app/screens/dashboard/widgets/recharge_service_section.dart';
import 'package:m2online_recharge_app/screens/dashboard/widgets/travel_section_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomSideDrawer(),
      appBar: CustomeAppbar(
        title: 'Dashboard',
        onNotificationTap: () {
          // Handle notification tap
        },
        onProfileTap: () {
          // Handle profile tap
        },
        notificationCount: 5, // Example notification count
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            CashbackBanner(),
            QuickTansfer(),
            QuickLinksSection(),
            RechargeServicesSection(),
            TravelSectionCard(),
            FinanceServiceSection(),
            FreeToolsSection(),
          ],
        ),
      ),
    );
  }
}
