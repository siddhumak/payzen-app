import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/utils/custom_button.dart';

class OtpForm extends StatelessWidget {
  final bool isOTPSent;
  final TextEditingController mobileController;
  final TextEditingController otpController;
  final VoidCallback sendOtp;
  final VoidCallback verifyOtp;
  final VoidCallback onChangeNumber;

  const OtpForm({
    super.key,
    required this.isOTPSent,
    required this.mobileController,
    required this.otpController,
    required this.sendOtp,
    required this.verifyOtp,
    required this.onChangeNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            isOTPSent ? 'Enter OTP' : 'Mobile Number',
            style: GoogleFonts.roboto(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          if (!isOTPSent) ...[
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    '+91',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    style: const TextStyle(
                      color:
                          AppColors
                              .primarydark, // 👈 This changes the input text color
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'Enter 10-digit mobile number',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            CustomButton(
              label: 'Send OTP',
              onPressed: sendOtp,
              icon: LucideIcons.send,
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            const SizedBox(height: 10),
          ] else ...[
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(
                fontSize: 18, // Matches text-lg
                letterSpacing: 6, // Matches tracking-widest
                color: Colors.black, // Or AppColors.foreground if defined
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: '6-digit OTP',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  letterSpacing: 2,
                ),
                counterText: '',
                filled: true,
                fillColor: Colors.grey.shade100, // Matches bg-background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
              label: 'Verify OTP',
              onPressed: verifyOtp,
              icon: LucideIcons.checkCircle,
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Didn\'t receive the code?',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: OutlinedButton(
                onPressed: () {}, // replace with your function
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary, // text color
                  side: BorderSide(
                    color: AppColors.primary.withOpacity(0.3), // light border
                  ),
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ), // small size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ).copyWith(
                  overlayColor: WidgetStateProperty.all(
                    AppColors.primary.withOpacity(0.1), // hover splash
                  ),
                ),
                child: const Text(
                  'Change Number',
                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
