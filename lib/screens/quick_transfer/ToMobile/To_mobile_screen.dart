import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/components/custom_header.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/models/contact_model.dart';
import 'package:payzen_app/screens/quick_transfer/pay_to_contact_screen.dart';
import 'package:payzen_app/screens/quick_transfer/widgets/recent_contacts_widgets.dart';
import 'package:payzen_app/screens/quick_transfer/widgets/refer_contact_card.dart';

class ToMobileScreen extends StatefulWidget {
  const ToMobileScreen({super.key});

  @override
  State<ToMobileScreen> createState() => _ToMobileScreenState();
}

class _ToMobileScreenState extends State<ToMobileScreen> {
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

    Contact(
      id: '5',
      name: 'Nikhil',
      phone: '9812345678',
      avatar: '',
      initials: 'N',
    ),

    Contact(
      id: '6',
      name: 'Dhanashree',
      phone: '9812345678',
      avatar: '',
      initials: 'D',
    ),

    Contact(
      id: '7',
      name: 'Aditya',
      phone: '9812345678',
      avatar: '',
      initials: 'A',
    ),

    Contact(
      id: '8',
      name: 'Sonu',
      phone: '9812345678',
      avatar: '',
      initials: 'S',
    ),
  ];

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

  String? selectedContactId;
  String searchQuery = '';
  Map<String, dynamic>? selectedContact;
  bool showAllContacts = false;

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mobileController.addListener(() {
      if (_mobileController.text.length == 10) {
        // Optionally trigger validation or UPI lookup
      }
    });
  }

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

  void onContactSelected(Contact contact) {
    Get.to(() => PayToContactScreen(contact: contact));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      body: Column(
        children: [
          // Header
          CustomHeader(
            title: 'Send Money',
            subtitle: 'Pay to any UPI Account',
            searchController: searchController,
            onSearchChanged: (value) {
              setState(() {
                searchController.text = value;
              });
            },
          ),

          if (recentContacts.isNotEmpty) ...[
            const SizedBox(height: 10),
            RecentContactsWidget(
              recentContacts: recentContacts,
              onContactSelected: onContactSelected,
            ),
            const SizedBox(height: 16),
            //All Contact
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(
                    LucideIcons.contact,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "All Contacts",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary, // from-primary/20
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Scrollable Contact List + View More + Remaining UI
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  ...filteredContacts.map((contact) {
                    return GestureDetector(
                      onTap: () {
                        final selected = Contact(
                          id: contact['id'].toString(),
                          name: contact['name'],
                          phone: contact['phone'],
                          avatar: '',
                          initials: contact['name'].toString().substring(0, 1),
                        );
                        onContactSelected(selected);
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
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
