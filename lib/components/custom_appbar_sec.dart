import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomAppBarSecond extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBack;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool showBackButton;

  const CustomAppBarSecond({
    super.key,
    required this.title,
    this.subtitle,
    this.onBack,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: const Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showBackButton)
              InkWell(
                onTap: onBack ?? () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: foregroundColor.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.arrowLeft,
                    color: foregroundColor,
                    size: 24,
                  ),
                ),
              )
            else
              const SizedBox(width: 40),

            // Title and Subtitle
            Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: foregroundColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) const SizedBox(height: 2),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: foregroundColor.withOpacity(0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }
}
