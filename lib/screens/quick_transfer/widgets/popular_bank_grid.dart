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
          'Popular banks',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            color: AppColors.deepNavyText,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            for (var i = 0; i < banks.length; i++) ...[
              _bankRow(banks[i]),
              if (i != banks.length - 1) const SizedBox(height: 9),
            ],
          ],
        ),
      ],
    );
  }

  Widget _bankRow(Map<String, String> bank) {
    final selected = selectedBank == bank['name'];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFEAF8F4) : AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? AppColors.electricMint : AppColors.borderLight,
          width: selected ? 1.5 : 1,
        ),
        boxShadow:
            selected
                ? const [
                  BoxShadow(
                    color: Color(0x1A19C6AE),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ]
                : const [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => onBankSelected(bank['name']!),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    color: AppColors.warmIvory,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    bank['logo']!,
                    fit: BoxFit.contain,
                    errorBuilder:
                        (_, __, ___) => const Icon(
                          Icons.account_balance_rounded,
                          color: AppColors.deepTeal,
                          size: 22,
                        ),
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bank['name']!,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.deepNavyText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Bank account',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.mutedSlate,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: Icon(
                    selected ? Icons.check_circle_rounded : Icons.chevron_right,
                    key: ValueKey(selected),
                    color: selected ? AppColors.deepTeal : AppColors.mutedSlate,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
