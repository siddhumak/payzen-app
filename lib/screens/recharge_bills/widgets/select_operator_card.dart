import 'package:flutter/material.dart';
import 'package:m2online_recharge_app/constant/app_gradients.dart';

class SelectOperatorCard extends StatelessWidget {
  final String selectedOperator;
  final Function(String) onSelect;

  const SelectOperatorCard({
    super.key,
    required this.selectedOperator,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> operators = [
      {"name": "Jio", "logo": 'assets/images/jio.png'},
      {"name": "Airtel", "logo": "assets/images/airtel.png"},
      {"name": "Vi", "logo": "assets/images/vi.png"},
      {"name": "BSNL", "logo": "assets/images/bsnl.png"},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Select Operator",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                itemCount: operators.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: (constraints.maxWidth / 2) / 60,
                ),
                itemBuilder: (context, index) {
                  final op = operators[index];
                  final isSelected = selectedOperator == (op['name'] as String);
                  return GestureDetector(
                    onTap: () => onSelect(op['name'] as String),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: isSelected ? AppGradients.gradient1 : null,
                        color: isSelected ? null : Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            op['logo'] as String,
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              op['name'] as String,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
