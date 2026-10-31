import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2online_recharge_app/constant/colors.dart';

class ElectricityBillEntryScreen extends StatefulWidget {
  final Map<String, dynamic>? biller;
  const ElectricityBillEntryScreen({super.key, this.biller});

  @override
  State<ElectricityBillEntryScreen> createState() =>
      _ElectricityBillEntryScreenState();
}

class _ElectricityBillEntryScreenState
    extends State<ElectricityBillEntryScreen> {
  final TextEditingController _accountController = TextEditingController();
  String selectedTag = '';

  final List<Map<String, dynamic>> tags = [
    {"id": "home", "label": "Home", "icon": "🏠"},
    {"id": "mom", "label": "Mom", "icon": "👩"},
    {"id": "office", "label": "Office", "icon": "🏢"},
    {"id": "other", "label": "Other", "icon": "📝"},
  ];

  @override
  Widget build(BuildContext context) {
    final biller = widget.biller ?? {'name': 'Adani Electricity', 'logo': '⚡'};
    final isValidAccount = _accountController.text.length >= 9;

    return Scaffold(
      backgroundColor: Color(0xFFF5F8FF),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "${biller['logo']}${biller['name']}",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Account Number",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      children: [
                        TextField(
                          controller: _accountController,
                          maxLength: 12,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText:
                                'Please enter your 9-digit Account Number',
                            counterText: '',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        Positioned(
                          right: 8,
                          top: 12,
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.remove_red_eye, size: 16),
                            label: const Text(
                              "View Sample Bill",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Enter the account number as shown on your electricity bill",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                    const SizedBox(height: 24),
                    const Text(
                      "Save this bill as (Optional)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          tags.map((tag) {
                            final isSelected = selectedTag == tag['id'];
                            return ChoiceChip(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    tag['icon'],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(tag['label']),
                                ],
                              ),
                              selected: isSelected,
                              onSelected:
                                  (_) => setState(
                                    () =>
                                        selectedTag =
                                            isSelected ? '' : tag['id'],
                                  ),
                              backgroundColor: Colors.grey.shade200,
                              selectedColor: Colors.blue.shade100,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.blue : Colors.black,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          }).toList(),
                    ),

                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed:
                          isValidAccount
                              ? () {
                                Get.offNamed(
                                  '/billDetails',
                                  arguments: {
                                    'biller': biller,
                                    'accountNumber': _accountController.text,
                                    'tag': selectedTag,
                                  },
                                );
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        "Proceed",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.blue.shade50,
                        border: Border.all(color: Colors.blue.shade100),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.shield,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "This allows the app to fetch your future bills so you can pay them on time",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.3),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Text(
                                        "🇮🇳",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      "Bharat Connect Verified",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
