import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2online_recharge_app/constant/colors.dart';
import 'package:m2online_recharge_app/models/contact_model.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/pay_to_contact_screen.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/bank_form_card.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/recent_contacts_widgets.dart';
import 'package:m2online_recharge_app/utils/custom_button.dart';

class ToBankScreen extends StatelessWidget {
  ToBankScreen({super.key});

  final List<Contact> recentContacts = [
    Contact(
      id: '1',
      name: 'Ravi',
      phone: '9876543210',
      avatar: '',
      initials: 'R',
    ),
    Contact(
      id: '2',
      name: 'Sneha',
      phone: '9876541230',
      avatar: '',
      initials: 'S',
    ),
    Contact(
      id: '3',
      name: 'Amit',
      phone: '9812345678',
      avatar: '',
      initials: 'A',
    ),
    Contact(
      id: '4',
      name: 'Sid',
      phone: '9812345678',
      avatar: '',
      initials: 'S',
    ),
  ];

  void onContactSelected(Contact contact) {
    Get.to(() => PayToContactScreen(contact: contact));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed('/main');
          },
        ),
        title: Text(
          "Enter Bank Details",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Bank Details
                  ToBankFormCard(),

                  SizedBox(height: 10),
                  CustomButton(
                    icon: Icons.send,
                    label: 'PAY',
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      Get.to(
                        () => PayToContactScreen(contact: recentContacts[0]),
                      );
                    },
                  ),

                  SizedBox(height: 10),

                  if (recentContacts.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    RecentContactsWidget(
                      recentContacts: recentContacts,
                      onContactSelected: onContactSelected,
                    ),
                    const SizedBox(height: 24),
                  ],
                  // You can add AllContactsSection here later if needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
