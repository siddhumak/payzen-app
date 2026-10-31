import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/screens/login/widgets/login_card.dart';

class LoginSelectionScreen extends StatelessWidget {
  const LoginSelectionScreen({super.key});

  void navigateToOTPLogin() {
    Get.offNamed('/otpLogin');
  }

  void navigateToPasswordLogin() {
    Get.offNamed('/passLogin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image (top half)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/red_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Content
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(height: 80),

                // Logo over image
                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      LucideIcons.shieldCheck,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  'Neo Gateway',
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Secure Financial Solutions',
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 50),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'How would you like to login?',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Choose your preferred method to access your account',
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        // OTP Login
                        GestureDetector(
                          onTap: navigateToOTPLogin,
                          child: LoginCard(
                            title: 'Login via OTP',
                            subtitle:
                                'Secure one-time password sent to your mobile',
                            icon: LucideIcons.smartphone,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primarydark,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password Login
                        GestureDetector(
                          onTap: navigateToPasswordLogin,
                          child: LoginCard(
                            title: 'Login with User ID & Password',
                            subtitle:
                                'Use your registered credentials to sign in',
                            icon: LucideIcons.lock,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primarydark,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),
                        // Footer
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Secured by HIC Gateway • Version 2.1.0',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
