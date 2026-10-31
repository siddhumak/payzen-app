import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginRedirectText extends StatelessWidget {
  const LoginRedirectText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => Get.offNamed('/passLogin'),
        child: RichText(
          text: TextSpan(
            style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]),
            children: const [
              TextSpan(text: "Already have an account? "),
              TextSpan(
                text: "Login",
                style: TextStyle(
                  color: Color(0xFFEA4335),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
