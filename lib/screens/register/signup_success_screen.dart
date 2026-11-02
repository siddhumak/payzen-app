import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';

class SignupSuccessScreen extends StatelessWidget {
  const SignupSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final phone = arguments is Map ? (arguments['phone']?.toString() ?? '') : '';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.midnightNavy,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.midnightNavy,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.midnightNavy, AppColors.deepTeal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            image: DecorationImage(
              image: AssetImage('assets/images/header_waves_bg.jpg'),
              fit: BoxFit.cover,
              opacity: 0.38,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset('assets/images/payzen_logo.png', width: 64, height: 64),
                  const SizedBox(height: 34),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.35, end: 1),
                    duration: const Duration(milliseconds: 750),
                    curve: Curves.elasticOut,
                    builder: (context, value, child) => Transform.scale(
                      scale: value,
                      child: Container(
                        width: 112,
                        height: 112,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF00A888).withOpacity(0.28),
                          border: Border.all(color: AppColors.electricMint, width: 3),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x6637F5CD),
                              blurRadius: 28,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.check, color: Colors.white, size: 64),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Registration\nsuccessful!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      height: 1.12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Your PayZen account has been created successfully.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFD7E9E8),
                      fontSize: 15,
                      height: 1.45,
                    ),
                  ),
                  if (phone.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      phone,
                      style: GoogleFonts.inter(
                        color: AppColors.electricMint,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () => Get.offNamed(
                        AppRoutes.register,
                        arguments: {'phone': phone},
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.electricMint,
                        foregroundColor: AppColors.midnightNavy,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue to Profile',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(LucideIcons.arrowRight, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
