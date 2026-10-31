import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';

class CustomTextField2 extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final bool showPassword;
  final VoidCallback? togglePassword;
  final TextInputType keyboardType;
  final double height;
  final double fontSize;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization textCapitalization;
  final Color? borderColor;
  final Widget? prefix;

  const CustomTextField2({
    super.key,
    required this.controller,
    required this.hint,
    this.isPassword = false,
    this.showPassword = false,
    this.togglePassword,
    this.keyboardType = TextInputType.text,
    this.height = 64,
    this.fontSize = 16,
    this.contentPadding,
    this.textCapitalization = TextCapitalization.none,
    this.borderColor,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          TextField(
            controller: controller,
            obscureText: isPassword && !showPassword,
            keyboardType: keyboardType,
            maxLength: isPassword ? 18 : null,
            textCapitalization: textCapitalization,
            style: TextStyle(
              fontSize: fontSize,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              counterText: '',
              hintText: hint,
              prefix: prefix,
              hintStyle: TextStyle(color: Colors.grey.shade500),
              filled: true,
              fillColor: Colors.white.withOpacity(0.5),
              contentPadding:
                  contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: borderColor ?? Colors.grey.shade600,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: borderColor ?? AppColors.primary),
              ),
            ),
          ),
          if (isPassword && togglePassword != null)
            Positioned(
              right: 8,
              top: 8,
              child: IconButton(
                icon: Icon(
                  showPassword ? LucideIcons.eyeOff : LucideIcons.eye,
                  size: 20,
                  color: Colors.grey,
                ),
                onPressed: togglePassword,
              ),
            ),
        ],
      ),
    );
  }
}
