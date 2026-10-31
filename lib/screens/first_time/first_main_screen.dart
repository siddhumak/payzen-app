import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:m2online_recharge_app/constant/colors.dart';
import 'package:m2online_recharge_app/screens/first_time/widgets/step1.dart';
import 'package:m2online_recharge_app/screens/first_time/widgets/step2.dart';
import 'package:m2online_recharge_app/screens/first_time/widgets/step3.dart';

class FirstTimeMainScreen extends StatelessWidget {
  FirstTimeMainScreen({super.key});

  final CarouselSliderController _carouselController =
      CarouselSliderController(); // Correct type for version 5

  final current = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Default background color
      body: Stack(
        children: [
          // // 🔹 Full-screen background image
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/images/red_white_background.jpg', // Replace with your background image path
          //     fit: BoxFit.cover,
          //   ),
          // ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: CarouselSlider(
                      items: [
                        //Set Language
                        // SetLanguageWidget(
                        //   onNext: () {
                        //     current.value = 1;
                        //     _carouselController.animateToPage(
                        //       current.value,
                        //       duration: Duration(milliseconds: 500),
                        //       curve: Curves.easeInOut,
                        //     );
                        //   },
                        // ),
                        //Step1 Widget
                        Step1Widget(
                          onNext: () {
                            current.value = 2;
                            _carouselController.animateToPage(
                              current.value,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        //Step2 Widget
                        Step2Widget(
                          onNext: () {
                            current.value = 3;
                            _carouselController.animateToPage(
                              current.value,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          onPrev: () {
                            current.value = 1;
                            _carouselController.animateToPage(
                              current.value,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        //Step3 Widget
                        Step3Widget(
                          onNext: () {
                            current.value = 4;
                            _carouselController.animateToPage(
                              current.value,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        //Step4 Widget
                        // Step4Widget(
                        //   onPrev: () {
                        //     current.value = 3;
                        //     _carouselController.animateToPage(
                        //       current.value,
                        //       duration: Duration(milliseconds: 500),
                        //       curve: Curves.easeInOut,
                        //     );
                        //   },
                        // ),
                      ],
                      carouselController:
                          _carouselController, // Pass the controller _carouselController,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          current.value = index; // Update observable
                        },
                        height: double.infinity,
                        aspectRatio: 2.0,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(
                          milliseconds: 800,
                        ),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  // Obx to track observable state and rebuild accordingly
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          height: 10,
                          width: current.value == index ? 24.0 : 10.0,
                          decoration: BoxDecoration(
                            color:
                                current.value == index
                                    ? AppColors.primary
                                    : Colors.grey,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ), // Add spacing below the indicator
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
