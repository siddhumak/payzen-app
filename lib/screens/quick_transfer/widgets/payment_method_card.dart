import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:m2online_recharge_app/constant/app_gradients.dart';
import 'package:m2online_recharge_app/constant/colors.dart';

class PaymentMethod {
  final int id;
  final IconData icon;
  final String name;
  final String balance;

  PaymentMethod({
    required this.id,
    required this.icon,
    required this.name,
    required this.balance,
  });
}

class PaymentMethodCard extends StatefulWidget {
  const PaymentMethodCard({super.key});

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  int selectedPaymentId = 1;

  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: 1,
      icon: LucideIcons.wallet,
      name: "Wallet",
      balance: "₹150 available",
    ),
    PaymentMethod(
      id: 2,
      icon: LucideIcons.creditCard,
      name: "Credit Card",
      balance: "Visa ending in 1234",
    ),
    PaymentMethod(
      id: 3,
      icon: LucideIcons.banknote,
      name: "UPI",
      balance: "yourname@upi",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Text(
            "Payment Method",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 24),
          ...paymentMethods.map((method) {
            final isSelected = selectedPaymentId == method.id;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedPaymentId = method.id;
                });
              },
              child: Transform.scale(
                scale: isSelected ? 1.02 : 1.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppGradients.gradient1 : null,
                    color: isSelected ? null : Colors.grey.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color:
                          isSelected
                              ? AppColors.primary
                              : Colors.white.withOpacity(0.1),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon + Text
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: AppGradients.gradient1,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              method.icon,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                method.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                method.balance,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Chevron only
                      const Icon(
                        LucideIcons.chevronRight,
                        color: Colors.white60,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
