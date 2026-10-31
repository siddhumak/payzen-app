import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';

class OtpLoginScreen extends StatefulWidget {
  const OtpLoginScreen({super.key});

  @override
  State<OtpLoginScreen> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {
  static const int _otpLength = 6;
  final List<TextEditingController> _controllers =
      List.generate(_otpLength, (index) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(_otpLength, (index) => FocusNode());

  String _phoneNumber = '+91 98765 43210';
  int _secondsRemaining = 28;
  Timer? _countdownTimer;
  bool _canResend = false;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();

    // Read phone passed from LoginSelectionScreen
    final args = Get.arguments;
    if (args != null && args is Map && args['phone'] != null) {
      final raw = args['phone'].toString().trim();
      if (raw.isNotEmpty) {
        _phoneNumber = '+91 $raw';
      }
    }

    _startTimer();

    // Auto-focus on the first OTP box
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _focusNodes.isNotEmpty) {
        _focusNodes[0].requestFocus();
      }
    });
  }

  void _startTimer() {
    _countdownTimer?.cancel();
    setState(() {
      _secondsRemaining = 28;
      _canResend = false;
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  void _onResendOtp() {
    if (_canResend) {
      _startTimer();
      // Clear inputs
      for (final c in _controllers) {
        c.clear();
      }
      _focusNodes[0].requestFocus();

      Get.snackbar(
        'OTP Resent',
        'A new 6-digit verification code has been sent.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.midnightNavy,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void _onOtpChanged(String value, int index) {
    if (value.length > 1) {
      // User pasted multi-digit text
      _handlePaste(value, index);
      return;
    }

    if (value.isNotEmpty) {
      if (index < _otpLength - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _verifyOtp();
      }
    }
  }

  void _handlePaste(String text, int startIndex) {
    final digits = text.replaceAll(RegExp(r'\D'), '');
    for (int i = 0; i < digits.length && (startIndex + i) < _otpLength; i++) {
      _controllers[startIndex + i].text = digits[i];
    }
    final nextIndex = mathMin(startIndex + digits.length, _otpLength - 1);
    _focusNodes[nextIndex].requestFocus();

    if (_getOtpCode().length == _otpLength) {
      _verifyOtp();
    }
  }

  int mathMin(int a, int b) => a < b ? a : b;

  String _getOtpCode() {
    return _controllers.map((c) => c.text).join();
  }

  void _verifyOtp() {
    final code = _getOtpCode();
    if (code.length == _otpLength && !_isVerifying) {
      setState(() => _isVerifying = true);

      // Smooth simulation to navigate into main application
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          Get.offAllNamed(AppRoutes.main);
        }
      });
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),

                        // ---------------------------------------------------
                        // 1. Back Navigation Button
                        // ---------------------------------------------------
                        GestureDetector(
                          onTap: () => Get.back(),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              LucideIcons.arrowLeft,
                              size: 24,
                              color: AppColors.deepNavyText,
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.035),

                        // ---------------------------------------------------
                        // 2. Heading: "Verify your number"
                        // ---------------------------------------------------
                        Text(
                          'Verify your number',
                          style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: AppColors.deepNavyText,
                            letterSpacing: -0.5,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Subtitle with highlighted phone number
                        Text(
                          'Enter the 6-digit OTP sent to',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mutedSlate,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _phoneNumber,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.electricMint,
                            letterSpacing: 0.3,
                          ),
                        ),

                        SizedBox(height: size.height * 0.045),

                        // ---------------------------------------------------
                        // 3. 6-Digit Individual OTP Input Boxes
                        // ---------------------------------------------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(_otpLength, (index) {
                            return _buildOtpBox(index, constraints.maxWidth);
                          }),
                        ),

                        SizedBox(height: size.height * 0.040),

                        // ---------------------------------------------------
                        // 4. Resend OTP Timer & Action
                        // ---------------------------------------------------
                        Center(
                          child: _canResend
                              ? GestureDetector(
                                  onTap: _onResendOtp,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Resend OTP',
                                      style: GoogleFonts.inter(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.electricMint,
                                      ),
                                    ),
                                  ),
                                )
                              : RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.mutedSlate,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Resend OTP in '),
                                      TextSpan(
                                        text:
                                            '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.electricMint,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),

                        const Spacer(),

                        // ---------------------------------------------------
                        // 5. Bottom Security Trust Badge
                        // ---------------------------------------------------
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Shield with checkmark icon
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF168568),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // Divider
                                Container(
                                  width: 1,
                                  height: 28,
                                  color: const Color(0xFFDCE2E7),
                                ),

                                const SizedBox(width: 12),

                                // Security Note
                                Flexible(
                                  child: Text(
                                    'Your data is safe and secure\nwith bank-grade encryption',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.mutedSlate,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index, double screenWidth) {
    // Proportional width: fits comfortably on small 320px screens up to large tablets
    final boxWidth = ((screenWidth - 48 - (5 * 10)) / _otpLength).clamp(42.0, 52.0);
    final isFocused = _focusNodes[index].hasFocus;
    final hasValue = _controllers[index].text.isNotEmpty;

    return Container(
      width: boxWidth,
      height: 58,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isFocused
              ? AppColors.deepTeal
              : (hasValue ? AppColors.electricMint : const Color(0xFFDCE2E8)),
          width: isFocused || hasValue ? 1.5 : 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06061C2B),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) {
          if (event is RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            if (_controllers[index].text.isEmpty && index > 0) {
              _focusNodes[index - 1].requestFocus();
              _controllers[index - 1].clear();
            }
          }
        },
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.deepNavyText,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (val) => _onOtpChanged(val, index),
        ),
      ),
    );
  }
}
