import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payzen_app/constant/app_gradients.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';
import 'package:payzen_app/utils/gradient_button.dart';

class Step3Widget extends StatelessWidget {
  final VoidCallback onNext;

  const Step3Widget({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth > 600 ? 600.0 : screenWidth;

        return Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.05,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 3D Elevated Image Card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/onboarding3.png',
                      height: screenHeight * 0.35,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.07),

                  // Gradient Heading
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return AppGradients.headingText.createShader(bounds);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Universal Acceptance',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Pay anywhere, anytime with our extensive network of merchants and banks.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexend(
                        fontSize: screenWidth < 350 ? 13 : 15,
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  GradientActionButton(
                    text: 'Next',
                    onPressed: () => Get.offNamed(AppRoutes.loginselect),
                    width: 200,
                  ),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: () => Get.offNamed(AppRoutes.loginselect),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
