import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m2online_recharge_app/components/custom_header.dart';
import 'package:m2online_recharge_app/constant/colors.dart';
import 'package:m2online_recharge_app/routes/app_routes.dart';
import 'package:m2online_recharge_app/screens/recharge_bills/widgets/select_operator_card.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/refer_contact_card.dart';
import 'package:m2online_recharge_app/utils/custom_button.dart';

class MobileRechargeHomeScreen extends StatefulWidget {
  const MobileRechargeHomeScreen({super.key});

  @override
  State<MobileRechargeHomeScreen> createState() =>
      _MobileRechargeHomeScreenState();
}

class _MobileRechargeHomeScreenState extends State<MobileRechargeHomeScreen> {
  final List<Map<String, dynamic>> contacts = [
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

  String mobileNumber = '';
  String operator = '';
  String circle = '';
  final TextEditingController searchController = TextEditingController();

  Map<String, dynamic>? selectedContact;
  bool showAllContacts = false;

  List<Map<String, dynamic>> get filteredContacts {
    final query = searchController.text.toLowerCase();
    final result =
        contacts.where((contact) {
          final name = contact['name'].toString().toLowerCase();
          final phone = contact['phone'].toString();
          return name.contains(query) || phone.contains(query);
        }).toList();

    if (!showAllContacts && result.length > 4) {
      return result.take(4).toList();
    }

    return result;
  }

  void detectOperator(String number) {
    if (number.length >= 4) {
      final prefix = number.substring(0, 4);
      if (["9876", "9877", "9878"].contains(prefix)) {
        setState(() {
          operator = "Jio";
          circle = "Delhi";
        });
      } else if (["9810", "9811", "9812"].contains(prefix)) {
        setState(() {
          operator = "Airtel";
          circle = "Delhi";
        });
      }
    }
  }

  void handleProceed() {
    if (mobileNumber.length == 10) {
      Get.toNamed(AppRoutes.planSelction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      body: Column(
        children: [
          // Header
          CustomHeader(
            title: 'Pay Mobile Recharge',
            subtitle: 'Recharge any mobile in seconds',
            searchController: searchController,
            onSearchChanged: (value) {
              setState(() {
                searchController.text = value;
              });
            },
          ),

          // Fixed My Number & Select Contact
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/jio.png'),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'My Number',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '+91 91234 56789',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Row(
                  children: [
                    Icon(Icons.contacts, color: Colors.black54, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Select Contact',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Scrollable Contact List + View More + Remaining UI
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ...filteredContacts.map((contact) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedContact = contact;
                        mobileNumber = contact['phone']
                            .replaceAll(RegExp(r'[^0-9]'), '')
                            .substring(2);
                        detectOperator(mobileNumber);
                      });
                    },
                    child: ReferContactCard(
                      contact: contact,
                      isSelected: selectedContact?['id'] == contact['id'],
                    ),
                  );
                }),

                // View More / View Less toggle
                if (searchController.text.isEmpty && contacts.length > 4)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          showAllContacts = !showAllContacts;
                        });
                      },
                      icon: Icon(
                        showAllContacts
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.primary,
                      ),
                      label: Text(
                        showAllContacts ? "View Less" : "View More",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 30),
                // Select Operator card
                const SizedBox(height: 30),
                SelectOperatorCard(
                  selectedOperator: operator,
                  onSelect: (value) {
                    setState(() {
                      operator = value;
                    });
                  },
                ),

                const SizedBox(height: 30),

                // Proceed To Plans button
                CustomButton(
                  label: 'Proceed To Plans',
                  backgroundColor:
                      mobileNumber.length == 10
                          ? AppColors.primary
                          : Colors.grey,
                  onPressed: handleProceed,
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
