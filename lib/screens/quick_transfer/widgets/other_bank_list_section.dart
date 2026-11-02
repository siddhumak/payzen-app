import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payzen_app/constant/colors.dart';

class OtherBankList extends StatefulWidget {
  final List<String> banks;
  final String? selectedBank;
  final bool showViewAll;
  final Function(String bank) onBankSelected;

  const OtherBankList({
    super.key,
    required this.banks,
    this.selectedBank,
    this.showViewAll = false,
    required this.onBankSelected,
  });

  @override
  State<OtherBankList> createState() => _OtherBankListState();
}

class _OtherBankListState extends State<OtherBankList> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final visibleBanks =
        widget.showViewAll && !_expanded
            ? widget.banks.take(5).toList()
            : widget.banks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Other banks',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            color: AppColors.deepNavyText,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              for (var index = 0; index < visibleBanks.length; index++) ...[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  color:
                      widget.selectedBank == visibleBanks[index]
                          ? const Color(0xFFEAF8F4)
                          : Colors.transparent,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                    leading: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEAF8F4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.account_balance_rounded,
                        color: AppColors.deepTeal,
                        size: 19,
                      ),
                    ),
                    title: Text(
                      visibleBanks[index],
                      style: GoogleFonts.inter(
                        color: AppColors.deepNavyText,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Icon(
                      widget.selectedBank == visibleBanks[index]
                          ? Icons.check_circle_rounded
                          : Icons.chevron_right,
                      color:
                          widget.selectedBank == visibleBanks[index]
                              ? AppColors.deepTeal
                              : AppColors.mutedSlate,
                    ),
                    onTap: () => widget.onBankSelected(visibleBanks[index]),
                  ),
                ),
                if (index < visibleBanks.length - 1)
                  const Divider(height: 1, indent: 66, endIndent: 12),
              ],
              if (widget.showViewAll && widget.banks.length > 5)
                TextButton(
                  onPressed: () => setState(() => _expanded = !_expanded),
                  child: Text(
                    _expanded ? 'Show fewer banks' : 'View all banks',
                    style: GoogleFonts.inter(
                      color: AppColors.deepTeal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
