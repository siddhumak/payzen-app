import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';

class SignupProgressScreen extends StatefulWidget {
  const SignupProgressScreen({super.key});

  @override
  State<SignupProgressScreen> createState() => _SignupProgressScreenState();
}

class _SignupProgressScreenState extends State<SignupProgressScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final String _phone;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments;
    _phone = arguments is Map ? (arguments['phone']?.toString() ?? '') : '';
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _timer = Timer(const Duration(milliseconds: 2200), () {
      if (mounted) {
        Get.offNamed(AppRoutes.signupSuccess, arguments: {'phone': _phone});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.warmIvory,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        body: Column(
          children: [
            Container(
              height: 210,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.midnightNavy, AppColors.deepTeal],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/header_waves_bg.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.34,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 18),
                    Image.asset('assets/images/payzen_logo.png', width: 54, height: 54),
                    const SizedBox(height: 14),
                    Text(
                      'Setting up your account…',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 22, 24, 28),
                child: Column(
                  children: [
                    _progressItem('Verifying mobile number', complete: true),
                    _progressItem('Creating your account', complete: true),
                    _progressItem('Preparing your profile', active: true),
                    _progressItem('Setting up secure access'),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.shieldCheck, color: AppColors.deepTeal),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Your account is protected with secure mobile verification.',
                              style: GoogleFonts.inter(
                                color: AppColors.mutedSlate,
                                fontSize: 13,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _progressItem(String title, {bool complete = false, bool active = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            height: 28,
            child: complete
                ? const Icon(Icons.check_circle, color: AppColors.successGreen)
                : active
                    ? RotationTransition(
                        turns: _controller,
                        child: const Icon(
                          LucideIcons.loader,
                          color: AppColors.electricMint,
                          size: 22,
                        ),
                      )
                    : const Icon(
                        Icons.circle_outlined,
                        color: Color(0xFFC7D0D5),
                        size: 22,
                      ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.inter(
              color: active ? AppColors.deepNavyText : AppColors.mutedSlate,
              fontSize: 15,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
