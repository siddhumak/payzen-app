import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:m2online_recharge_app/constant/colors.dart';
import 'package:m2online_recharge_app/models/contact_model.dart';

class AllContactsSection extends StatefulWidget {
  final List<Contact> contacts;
  final Function(Contact) onContactSelected;

  const AllContactsSection({
    super.key,
    required this.contacts,
    required this.onContactSelected,
  });

  @override
  State<AllContactsSection> createState() => _AllContactsSectionState();
}

class _AllContactsSectionState extends State<AllContactsSection> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final grouped = _groupContacts(widget.contacts);
    final displayedGroups = _getLimitedGroupedContacts(grouped);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      colors: [AppColors.primary, Colors.transparent],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Contacts List
        ...displayedGroups.entries.expand(
          (entry) => [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4, left: 16),
              child: Text(
                entry.key,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            ...entry.value.map(
              (contact) => GestureDetector(
                onTap: () => widget.onContactSelected(contact),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        contact.initials,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      contact.name,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    subtitle: Text(
                      contact.phone,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.black38,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ),
              ),
            ),
          ],
        ),

        // View All / View Less button
        if (widget.contacts.length > 5)
          Center(
            child: TextButton(
              onPressed: () => setState(() => showAll = !showAll),
              child: Text(
                showAll ? "View Less" : "View All",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Groups contacts by the first letter of the name
  Map<String, List<Contact>> _groupContacts(List<Contact> contacts) {
    Map<String, List<Contact>> grouped = {};
    for (var contact in contacts) {
      String group = contact.name[0].toUpperCase();
      grouped.putIfAbsent(group, () => []).add(contact);
    }
    return grouped;
  }

  /// Limits to top N contacts if [showAll] is false
  Map<String, List<Contact>> _getLimitedGroupedContacts(
    Map<String, List<Contact>> grouped,
  ) {
    if (showAll) return grouped;

    int count = 0;
    const maxContacts = 5;
    Map<String, List<Contact>> limited = {};

    for (var entry in grouped.entries) {
      List<Contact> subset = [];
      for (var contact in entry.value) {
        if (count >= maxContacts) break;
        subset.add(contact);
        count++;
      }
      if (subset.isNotEmpty) {
        limited[entry.key] = subset;
      }
      if (count >= maxContacts) break;
    }

    return limited;
  }
}
