import 'package:flutter/material.dart';
import 'package:m2online_recharge_app/constant/colors.dart';

class ReferFilterChips extends StatelessWidget {
  final List<String> filters;
  final String activeFilter;
  final ValueChanged<String> onFilterSelected;

  const ReferFilterChips({
    super.key,
    required this.filters,
    required this.activeFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children:
            filters.map((chip) {
              final isActive = activeFilter == chip;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(chip),
                  selected: isActive,
                  onSelected: (_) => onFilterSelected(chip),
                  selectedColor: AppColors.primary,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isActive ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
