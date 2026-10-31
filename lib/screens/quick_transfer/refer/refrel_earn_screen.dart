import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:m2online_recharge_app/components/search_bar.dart';
import 'package:m2online_recharge_app/constant/colors.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/filter_chips.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/refer_actions.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/refer_contact_card.dart';

class ReferEarnScreen extends StatefulWidget {
  const ReferEarnScreen({super.key});

  @override
  State<ReferEarnScreen> createState() => _ReferEarnScreenState();
}

class _ReferEarnScreenState extends State<ReferEarnScreen> {
  final TextEditingController searchController = TextEditingController();
  String activeFilter = 'All';
  String? selectedAction;

  final filterChips = ['All', 'Invite to App', 'Reactivate'];

  final contacts = [
    {
      'id': 1,
      'name': 'Rahul Sharma',
      'phone': '+91 98765 43210',
      'status': 'new',
    },
    {
      'id': 2,
      'name': 'Priya Singh',
      'phone': '+91 87654 32109',
      'status': 'reactivate',
    },
    {
      'id': 3,
      'name': 'Amit Kumar',
      'phone': '+91 76543 21098',
      'status': 'new',
    },
    {
      'id': 4,
      'name': 'Sneha Patel',
      'phone': '+91 65432 10987',
      'status': 'invited',
    },
    {
      'id': 5,
      'name': 'Vikash Gupta',
      'phone': '+91 54321 09876',
      'status': 'new',
    },
    {
      'id': 6,
      'name': 'Anita Rao',
      'phone': '+91 43210 98765',
      'status': 'reactivate',
    },
    {
      'id': 7,
      'name': 'Rohan Verma',
      'phone': '+91 32109 87654',
      'status': 'new',
    },
    {
      'id': 8,
      'name': 'Kavya Nair',
      'phone': '+91 21098 76543',
      'status': 'invited',
    },
  ];

  String getRewardText(String status) {
    switch (status) {
      case 'new':
        return 'Invite & Win ₹20';
      case 'reactivate':
        return 'Reactivate & Win ₹15';
      case 'invited':
        return 'Invited ✓';
      default:
        return '';
    }
  }

  Color getRewardColor(String status) {
    switch (status) {
      case 'new':
        return Colors.green.shade600;
      case 'reactivate':
        return Colors.blue.shade600;
      case 'invited':
        return Colors.grey;
      default:
        return Colors.green;
    }
  }

  Color getRewardBG(String status) {
    switch (status) {
      case 'new':
        return Colors.green.shade50;
      case 'reactivate':
        return Colors.blue.shade50;
      case 'invited':
        return Colors.grey.shade100;
      default:
        return Colors.green.shade50;
    }
  }

  List<Map<String, dynamic>> get filteredContacts {
    return contacts.where((contact) {
      final query = searchController.text.toLowerCase();
      final name = contact['name'].toString().toLowerCase();
      final phone = contact['phone'].toString();
      final matchesSearch = name.contains(query) || phone.contains(query);

      if (activeFilter == 'All') return matchesSearch;
      if (activeFilter == 'Invite to App') {
        return matchesSearch && contact['status'] == 'new';
      }
      if (activeFilter == 'Reactivate') {
        return matchesSearch && contact['status'] == 'reactivate';
      }
      return matchesSearch;
    }).toList();
  }

  String getInitials(String name) {
    return name.split(' ').map((e) => e[0]).take(2).join().toUpperCase();
  }

  void handleAction(String id) {
    setState(() => selectedAction = id);
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => selectedAction = null);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Action: $id')));
  }

  void handleInvite(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invitation sent to $name! ₹20 reward pending.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      //appbar
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed('/main'),
        ),
        title: Text(
          "Refer & Earn",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      //Quick Action
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ReferActions(
                    icon: LucideIcons.trendingUp,
                    label: "Track\nReferrals",
                    color: Colors.blue,
                    onTap: () {},
                  ),
                  ReferActions(
                    icon: LucideIcons.messageCircle,
                    label: "WhatsApp\nInvite",
                    color: Colors.green,
                    onTap: () {},
                  ),
                  ReferActions(
                    icon: LucideIcons.qrCode,
                    label: "Share\nQR Code",
                    color: Colors.purple,
                    onTap: () {},
                  ),
                  ReferActions(
                    icon: LucideIcons.helpCircle,
                    label: "How it\nWorks",
                    color: Colors.orange,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ContactSearchBar(
                onSearchChanged: (value) {
                  setState(() {
                    searchController.text = value;
                  });
                },
              ),
            ),
            // Filter Chips
            ReferFilterChips(
              filters: filterChips,
              activeFilter: activeFilter,
              onFilterSelected: (chip) {
                setState(() => activeFilter = chip);
              },
            ),

            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredContacts.length,
                itemBuilder: (_, index) {
                  final contact = filteredContacts[index];
                  final status = contact['status'];
                  final invited = status == 'invited';

                  return ReferContactCard(
                    contact: contact,
                    invited: invited,
                    onInvite: () => handleInvite(contact['name']),
                    getInitials: getInitials,
                    getRewardBG: getRewardBG,
                    getRewardColor: getRewardColor,
                    getRewardText: getRewardText,
                  );
                },
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
