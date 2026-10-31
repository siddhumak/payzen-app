import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payzen_app/constant/colors.dart';

class PopularBankGrid extends StatelessWidget {
  final List<Map<String, String>> banks;
  final String? selectedBank; // <-- make this nullable
  final Function(String) onBankSelected;

  const PopularBankGrid({
    super.key,
    required this.banks,
    required this.selectedBank,
    required this.onBankSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🏦   Popular Banks',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          itemCount: banks.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 100,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (_, i) {
            final bank = banks[i];
            final isSelected = selectedBank == bank['name']; // works with null
            return GestureDetector(
              onTap: () => onBankSelected(bank['name']!),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.indigo.shade50 : Colors.white,
                  border: Border.all(
                    color:
                        isSelected ? AppColors.primary : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:
                      isSelected
                          ? [
                            BoxShadow(
                              color: Colors.indigo.shade100,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ]
                          : [],
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(
                        int.parse('0xFF${bank['color']!.substring(1)}'),
                      ),
                      backgroundImage: AssetImage(bank['logo']!),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      bank['name']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
