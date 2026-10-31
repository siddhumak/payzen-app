import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:m2online_recharge_app/constant/colors.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/glass_card.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/info_row.dart';
import 'package:m2online_recharge_app/utils/custom_button.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final String mobileNumber;
  final String operator;
  final Map<String, dynamic> selectedPlan;
  final String transactionId;
  final String paymentMethod;

  const PaymentSuccessScreen({
    super.key,
    required this.mobileNumber,
    required this.operator,
    required this.selectedPlan,
    required this.transactionId,
    required this.paymentMethod,
  });

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen>
    with TickerProviderStateMixin {
  bool showSuccess = false;
  bool showConfetti = false;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => showSuccess = true);
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() => showConfetti = true);
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
            child: Column(
              children: [
                // Confetti
                if (showConfetti)
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConfettiWidget(
                      confettiController: _confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      shouldLoop: false,
                      colors: const [
                        Colors.green,
                        Colors.lightGreen,
                        Colors.amber,
                        Colors.white,
                        Colors.blueAccent,
                      ],
                      numberOfParticles: 50,
                      maxBlastForce: 25,
                      minBlastForce: 10,
                      gravity: 0.2,
                      emissionFrequency: 0.02,
                    ),
                  ),

                // Success Icon
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 700),
                  opacity: showSuccess ? 1 : 0,
                  child: AnimatedScale(
                    scale: showSuccess ? 1 : 0,
                    duration: const Duration(milliseconds: 700),
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Colors.green, Colors.lightGreen],
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Success Text
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 700),
                  opacity: showSuccess ? 1 : 0,
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback:
                            (bounds) => const LinearGradient(
                              colors: [AppColors.primary, Colors.indigo],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                            ),
                        child: Text(
                          "Payment Successful!",
                          style: GoogleFonts.inter(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // required for ShaderMask
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Your recharge has been completed",
                        style: GoogleFonts.inter(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Transaction Card
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // "₹${widget.selectedPlan['price']}",
                        "₹300",
                        style: GoogleFonts.inter(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..color = Colors.black87,
                        ),
                      ),
                      const Text(
                        "Recharge Completed",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      InfoRow(
                        label: "Mobile Number",
                        value: widget.mobileNumber,
                      ),
                      InfoRow(label: "Operator", value: widget.operator),
                      InfoRow(
                        label: "Plan Validity",
                        value: widget.selectedPlan['validity'] ?? 'N/A',
                      ),
                      InfoRow(
                        label: "Transaction ID",
                        value: widget.transactionId,
                      ),
                      InfoRow(
                        label: "Payment Method",
                        value: widget.paymentMethod,
                      ),
                      InfoRow(
                        label: "Date & Time",
                        value: currentTime.toString(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                CustomButton(
                  label: 'Download Receipt',
                  onPressed: () {},
                  icon: Icons.download,
                  backgroundColor: AppColors.primary,
                ),

                const SizedBox(height: 32),

                GlassCard(
                  child: Column(
                    children: [
                      const Text(
                        "Rate your experience",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            size: 28,
                            color: Colors.amberAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 🔙 Back Button (top-left)
          Positioned(
            top: 50,
            left: 25,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
