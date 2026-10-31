import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';
import 'package:payzen_app/screens/recharge_bills/widgets/plan_card.dart';
import 'package:payzen_app/screens/recharge_bills/widgets/search_field.dart';

class PlanSelectionScreen extends StatefulWidget {
  final String mobileNumber;
  final String operator;
  final String circle;

  const PlanSelectionScreen({
    super.key,
    required this.mobileNumber,
    required this.operator,
    required this.circle,
  });

  @override
  State<PlanSelectionScreen> createState() => _PlanSelectionScreenState();
}

class _PlanSelectionScreenState extends State<PlanSelectionScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _searchTerm = '';
  Map<String, List<Map<String, dynamic>>> plans = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    plans = {
      'recommended': [
        {
          'id': 1,
          'price': '₹399',
          'validity': '84 days',
          'data': '2GB/day',
          'calls': 'Unlimited',
          'sms': '100/day',
          'benefits': ['Disney+ Hotstar', 'JioTV', 'JioSaavn'],
          'popular': true,
        },
        {
          'id': 2,
          'price': '₹599',
          'validity': '84 days',
          'data': '2GB/day',
          'calls': 'Unlimited',
          'sms': '100/day',
          'benefits': ['Netflix', 'Amazon Prime', 'Disney+ Hotstar'],
          'popular': false,
        },
      ],
      'data': [
        {
          'id': 3,
          'price': '₹199',
          'validity': '24 days',
          'data': '1.5GB/day',
          'calls': 'Unlimited',
          'sms': '100/day',
          'benefits': ['JioTV', 'JioSaavn'],
          'popular': false,
        },
        {
          'id': 4,
          'price': '₹499',
          'validity': '56 days',
          'data': '3GB/day',
          'calls': 'Unlimited',
          'sms': '100/day',
          'benefits': ['Disney+ Hotstar', 'JioTV'],
          'popular': true,
        },
      ],
      'talktime': [
        {
          'id': 5,
          'price': '₹99',
          'validity': '18 days',
          'data': '200MB/day',
          'calls': '300 mins',
          'sms': '100/day',
          'benefits': ['JioTV'],
          'popular': false,
        },
      ],
      'unlimited': [
        {
          'id': 6,
          'price': '₹799',
          'validity': '90 days',
          'data': 'Unlimited',
          'calls': 'Unlimited',
          'sms': '100/day',
          'benefits': [
            'Netflix',
            'Amazon Prime',
            'Disney+ Hotstar',
            'YouTube Premium',
          ],
          'popular': true,
        },
      ],
    };
  }

  void _handlePlanSelect(Map<String, dynamic> plan) {
    Get.toNamed(
      AppRoutes.reviewpay,
      arguments: {
        'mobileNumber': widget.mobileNumber,
        'operator': widget.operator,
        'circle': widget.circle,
        'selectedPlan': plan,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ["Recommended", "Data", "Talktime", "Unlimited"];
    final icons = [
      LucideIcons.star,
      LucideIcons.wifi,
      LucideIcons.phone,
      LucideIcons.zap,
    ];

    return Scaffold(
      backgroundColor: Color(0xFFF5F8FF),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed('/main');
          },
        ),
        title: Text(
          "Select Your Plan",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          //searchfield
          SearchField(
            hintText: "Search plans by price or benefits",
            onChanged: (val) => setState(() => _searchTerm = val),
          ),
          TabBar(
            controller: _tabController,
            tabs: List.generate(
              tabs.length,
              (index) => Tab(icon: Icon(icons[index]), text: tabs[index]),
            ),
            labelColor: AppColors.primarydark,
            indicatorColor: AppColors.primarydark,
            unselectedLabelColor: Colors.black45,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:
                  tabs.map((key) {
                    final tabKey = key.toLowerCase();
                    final filteredPlans =
                        plans[tabKey]!.where((plan) {
                          return plan.toString().toLowerCase().contains(
                            _searchTerm.toLowerCase(),
                          );
                        }).toList();

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredPlans.length,
                      itemBuilder: (_, i) {
                        final plan = filteredPlans[i];
                        return PlanCard(
                          plan: plan,
                          onTap: () => _handlePlanSelect(plan),
                        );
                      },
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
