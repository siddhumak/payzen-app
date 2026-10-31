import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/models/contact_model.dart';

class RecentContactsWidget extends StatelessWidget {
  final List<Contact> recentContacts;
  final Function(Contact) onContactSelected;

  const RecentContactsWidget({
    super.key,
    required this.recentContacts,
    required this.onContactSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            children: [
              Icon(LucideIcons.contact, size: 18, color: AppColors.primary),
              SizedBox(width: 10),
              Text(
                "Recent Accounts",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              const Text(
                "Swipe to see more",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Horizontal Scroll List
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recentContacts.length,
              itemBuilder: (context, index) {
                final contact = recentContacts[index];
                return GestureDetector(
                  onTap: () => onContactSelected(contact),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: index == recentContacts.length - 1 ? 0 : 12,
                    ),
                    child: RecentContactCard(contact: contact),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Contact Card (with phone number instead of bank/mask)
class RecentContactCard extends StatelessWidget {
  final Contact contact;

  const RecentContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final color =
        AppColors.avatarColors[contact.name.hashCode %
            AppColors.avatarColors.length];

    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  contact.initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -2,
              right: -2,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                ),
                child: const Center(
                  child: Icon(
                    LucideIcons.building2,
                    size: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 64,
          child: Text(
            contact.name.split(' ')[0],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: 64,
          child: Text(
            '******${contact.phone.substring(contact.phone.length - 4)}',
            style: const TextStyle(fontSize: 11, color: Colors.grey),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
