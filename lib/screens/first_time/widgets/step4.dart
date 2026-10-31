import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payzen_app/utils/gradient_button.dart';

class Step4Widget extends StatelessWidget {
  final VoidCallback onPrev;

  const Step4Widget({super.key, required this.onPrev});

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
                  Material(
                    elevation: 12,
                    shadowColor: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/onboarding5.png',
                        height: screenHeight * 0.35,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.1),

                  // Gradient Heading
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [Colors.purple, Colors.pink],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'stepper.shareQr'.tr,
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
                      'stepper.shareQRMsg'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth < 350 ? 13 : 15,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  GradientActionButton(
                    text: 'stepper.started'.tr,
                    onPressed: () => Get.toNamed("/signup"),
                    width: 200,
                  ),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: onPrev,
                    child: Text(
                      'stepper.goBack'.tr,
                      style: TextStyle(
                        color: Colors.deepPurple.shade600,
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
