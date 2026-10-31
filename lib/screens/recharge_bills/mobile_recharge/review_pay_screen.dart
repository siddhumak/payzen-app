import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:m2online_recharge_app/constant/colors.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/payment_method_card.dart';
import 'package:m2online_recharge_app/utils/custom_button.dart';

class ReviewPayScreen extends StatelessWidget {
  ReviewPayScreen({super.key});

  final String mobileNumber = '9876543210';
  final String operator = 'Jio';
  final Map<String, dynamic> selectedPlan = {
    'price': 299,
    'validity': '28 days',
  };

  int calculateTotal() {
    return selectedPlan['price'];
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
          "Review & Pay",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Recharge Summary Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row with title and secured icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Recharge Summary',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  LucideIcons.shieldCheck,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Secured',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Summary rows
                        _buildRow('Mobile Number', mobileNumber),
                        _buildRow('Operator', operator),
                        _buildRow('Plan Amount', '₹${selectedPlan['price']}'),
                        _buildRow('Validity', selectedPlan['validity']),

                        const SizedBox(height: 24),

                        // Total
                        Divider(
                          color: AppColors.primary.withOpacity(0.3),
                          thickness: 2,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '₹${calculateTotal()}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Payment Method Selection
                  const PaymentMethodCard(),

                  SizedBox(height: 32),

                  CustomButton(
                    icon: LucideIcons.lock,
                    label: 'Pay Securely ₹${calculateTotal()}',
                    onPressed: () {
                      Get.offNamed('/paymentSuccess');
                    },
                    backgroundColor: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const Divider(color: Colors.black12, thickness: 1, height: 24),
      ],
    );
  }
}
