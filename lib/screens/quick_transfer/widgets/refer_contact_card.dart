import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';

class ReferContactCard extends StatelessWidget {
  final Map<String, dynamic> contact;
  final bool? invited;
  final bool isSelected;
  final VoidCallback? onInvite;
  final String Function(String name)? getInitials;
  final Color Function(String status)? getRewardBG;
  final Color Function(String status)? getRewardColor;
  final String Function(String status)? getRewardText;

  const ReferContactCard({
    required this.contact,
    this.invited,
    this.isSelected = false,
    this.onInvite,
    this.getInitials,
    this.getRewardBG,
    this.getRewardColor,
    this.getRewardText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final status = contact['status'];
    final hasReward =
        getRewardBG != null &&
        getRewardColor != null &&
        getRewardText != null &&
        status != null;

    final cardColor = isSelected ? AppColors.primary : Colors.white;
    final textColor = isSelected ? Colors.white : Colors.black;
    final subTextColor = isSelected ? Colors.white70 : Colors.grey;
    final avatarBG = isSelected ? Colors.white : AppColors.primary;
    final avatarTextColor = isSelected ? AppColors.primary : Colors.white;
    final iconColor = Colors.white;

    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      isSelected
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: avatarBG,
                  child: Text(
                    getInitials != null
                        ? getInitials!(contact['name'])
                        : contact['name']
                            .toString()
                            .substring(0, 1)
                            .toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: avatarTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      contact['phone'],
                      style: TextStyle(fontSize: 12, color: subTextColor),
                    ),
                    const SizedBox(height: 4),
                    if (hasReward)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: getRewardBG!(status),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          getRewardText!(status),
                          style: TextStyle(
                            color: getRewardColor!(status),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (onInvite != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: IconButton(
                    onPressed: (invited ?? false) ? null : onInvite,
                    icon: const Icon(LucideIcons.messageCircle, size: 16),
                    color: iconColor,
                    disabledColor: Colors.grey.shade300,
                    style: IconButton.styleFrom(
                      backgroundColor:
                          (invited ?? false)
                              ? Colors.grey.shade100
                              : Colors.green,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // ✅ Selection Tick Icon
        if (isSelected)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4),
              child: Icon(Icons.check, color: AppColors.primary, size: 14),
            ),
          ),
      ],
    );
  }
}
