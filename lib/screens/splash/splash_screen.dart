import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/app_gradients.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(
        AppRoutes.first,
      ); // Navigate to the first time screen after 3 seconds
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: AppGradients.splashBackground,
            ),
          ),

          // Background Decorations
          Positioned(
            top: 80,
            left: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.blurWhite05,
                shape: BoxShape.circle,
              ),
              child: const SizedBox(width: 128, height: 128),
            ),
          ),
          Positioned(
            bottom: 120,
            right: 32,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.blurWhite10,
                shape: BoxShape.circle,
              ),
              child: const SizedBox(width: 96, height: 96),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            right: 80,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.blurWhite05,
                shape: BoxShape.circle,
              ),
              child: const SizedBox(width: 64, height: 64),
            ),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.whiteDim.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Center(
                        child: Icon(
                          LucideIcons.zap,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'NeoPay',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Smart. Secure. Simple.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Loading Indicator
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.whiteDim.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 3),
                    builder: (context, value, child) {
                      return FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: value,
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Initializing secure connection...',
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
