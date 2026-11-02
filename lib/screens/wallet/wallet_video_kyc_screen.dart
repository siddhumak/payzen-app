import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';
import 'package:payzen_app/screens/wallet/widgets/wallet_activation_progress.dart';

class WalletVideoKycScreen extends StatefulWidget {
  const WalletVideoKycScreen({super.key});

  @override
  State<WalletVideoKycScreen> createState() => _WalletVideoKycScreenState();
}

class _WalletVideoKycScreenState extends State<WalletVideoKycScreen> {
  late final ConfettiController _confettiController = ConfettiController(
    duration: const Duration(seconds: 3),
  );
  bool _consentGiven = false;
  bool _verifying = false;
  bool _verified = false;

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _startMockVerification() async {
    if (!_consentGiven) {
      Get.snackbar(
        'Consent required',
        'Please agree before starting the Video KYC preview.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.deepTeal,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    setState(() => _verifying = true);
    await Future<void>.delayed(const Duration(milliseconds: 1900));
    if (!mounted) return;
    setState(() {
      _verifying = false;
      _verified = true;
    });
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).height < 760;
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppBar(
        title: Text(
          'Activate PayZen Wallet',
          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 17),
        ),
        backgroundColor: AppColors.deepTeal,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: Image.asset(
          'assets/images/header_waves_bg.jpg',
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        actions: [
          IconButton(
            tooltip: 'Video KYC help',
            onPressed:
                () => Get.snackbar(
                  'Video KYC preview',
                  'This demo simulates verification and does not open the camera.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.deepTeal,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(16),
                ),
            icon: const Icon(Icons.help_outline_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 158,
            child: Image(
              image: AssetImage('assets/images/header_waves_bg.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Positioned.fill(
            top: 142,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
            ),
          ),
          Positioned(
            top: 15,
            left: 20,
            right: 20,
            child: WalletActivationProgress(
              activeStep: 4,
              compact: MediaQuery.sizeOf(context).width < 380,
              darkBackground: true,
            ),
          ),
          SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 164, 20, compact ? 20 : 28),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 360),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child:
                        _verified
                            ? _verifiedContent(compact)
                            : _preparationContent(compact),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 34,
                maxBlastForce: 20,
                minBlastForce: 8,
                gravity: 0.2,
                emissionFrequency: 0.035,
                colors: const [
                  AppColors.electricMint,
                  AppColors.deepTeal,
                  Color(0xFFFFC857),
                  Colors.white,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _preparationContent(bool compact) => Column(
    key: const ValueKey('prepare-video-kyc'),
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Complete Video KYC',
                  style: GoogleFonts.inter(
                    color: AppColors.deepNavyText,
                    fontSize: compact ? 21 : 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'A quick 30–60 second video check to confirm your identity.',
                  style: GoogleFonts.inter(
                    color: AppColors.mutedSlate,
                    fontSize: compact ? 13 : 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _VideoIllustration(size: compact ? 70 : 84),
        ],
      ),
      SizedBox(height: compact ? 14 : 18),
      Container(
        padding: EdgeInsets.all(compact ? 14 : 17),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE3EAED)),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 12,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Keep these ready',
              style: GoogleFonts.inter(
                color: AppColors.deepNavyText,
                fontSize: compact ? 16 : 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: compact ? 6 : 10),
            _KycTipRow(
              icon: Icons.lightbulb_outline_rounded,
              title: 'Good lighting',
              detail: 'Sit in a well-lit area',
            ),
            _KycTipRow(
              icon: Icons.camera_alt_outlined,
              title: 'Clear and stable video',
              detail: 'Keep your face within the frame',
            ),
            _KycTipRow(
              icon: Icons.badge_outlined,
              title: 'Original ID (if asked)',
              detail: 'Keep your PAN or Aadhaar handy',
              showDivider: false,
            ),
          ],
        ),
      ),
      SizedBox(height: compact ? 12 : 16),
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 10 : 13,
          vertical: compact ? 9 : 12,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF5FAF9),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE5ECEF)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: _consentGiven,
              onChanged:
                  _verifying
                      ? null
                      : (value) =>
                          setState(() => _consentGiven = value ?? false),
              activeColor: AppColors.deepTeal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: InkWell(
                onTap:
                    _verifying
                        ? null
                        : () => setState(() => _consentGiven = !_consentGiven),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text.rich(
                    TextSpan(
                      style: GoogleFonts.inter(
                        color: AppColors.deepNavyText,
                        fontSize: compact ? 12 : 13,
                        height: 1.4,
                      ),
                      children: const [
                        TextSpan(text: 'I agree to the '),
                        TextSpan(
                          text: 'Video KYC terms',
                          style: TextStyle(
                            color: AppColors.deepTeal,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' and consent to recording and using my video for verification.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 9),
      Text(
        'Mock preview only — no camera is opened and no video is recorded.',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          color: AppColors.mutedSlate,
          fontSize: 11,
          height: 1.35,
        ),
      ),
      SizedBox(height: compact ? 14 : 19),
      _ActionButton(
        label: _verifying ? 'Verifying identity…' : 'Start Video KYC',
        icon: _verifying ? null : Icons.videocam_outlined,
        loading: _verifying,
        onPressed: _verifying ? null : _startMockVerification,
      ),
    ],
  );

  Widget _verifiedContent(bool compact) => Container(
    key: const ValueKey('video-kyc-complete'),
    padding: EdgeInsets.all(compact ? 20 : 26),
    decoration: BoxDecoration(
      color: AppColors.pureWhite,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: const Color(0xFFD6EFE8)),
      boxShadow: const [
        BoxShadow(
          color: AppColors.cardShadow,
          blurRadius: 16,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.55, end: 1),
          duration: const Duration(milliseconds: 650),
          curve: Curves.elasticOut,
          builder:
              (context, scale, child) =>
                  Transform.scale(scale: scale, child: child),
          child: Container(
            width: compact ? 82 : 96,
            height: compact ? 82 : 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE6F8F2),
              border: Border.all(color: AppColors.electricMint, width: 2),
              boxShadow: const [
                BoxShadow(color: Color(0x2219C6AE), blurRadius: 18),
              ],
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.deepTeal,
              size: 52,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Video KYC complete',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: AppColors.deepNavyText,
            fontSize: compact ? 22 : 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your identity check is complete in this mock preview. Your wallet activation is ready for the final confirmation.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: AppColors.mutedSlate,
            fontSize: 14,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 20),
        _ActionButton(
          label: 'Finish Wallet Activation',
          icon: Icons.arrow_forward_rounded,
          onPressed: () => Get.offAllNamed(AppRoutes.walletActivationComplete),
        ),
      ],
    ),
  );
}

class _VideoIllustration extends StatelessWidget {
  const _VideoIllustration({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.92, end: 1),
    duration: const Duration(milliseconds: 550),
    curve: Curves.easeOutBack,
    builder:
        (context, scale, child) => Transform.scale(scale: scale, child: child),
    child: SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size * 0.9,
            height: size * 0.9,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFE5FAF4), Color(0xFFC9F0E7)],
              ),
            ),
          ),
          Container(
            width: size * 0.48,
            height: size * 0.66,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(size * 0.12),
              border: Border.all(color: AppColors.deepTeal, width: 2),
              boxShadow: const [
                BoxShadow(color: Color(0x1A003D46), blurRadius: 8),
              ],
            ),
            child: Icon(
              Icons.person_rounded,
              color: AppColors.deepTeal,
              size: size * 0.34,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 3,
            child: Container(
              width: size * 0.36,
              height: size * 0.36,
              decoration: const BoxDecoration(
                color: AppColors.deepTeal,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.videocam_rounded,
                color: Colors.white,
                size: size * 0.21,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _KycTipRow extends StatelessWidget {
  const _KycTipRow({
    required this.icon,
    required this.title,
    required this.detail,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String detail;
  final bool showDivider;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: Color(0xFFE5F7F2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.deepTeal, size: 21),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: AppColors.deepNavyText,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    detail,
                    style: GoogleFonts.inter(
                      color: AppColors.mutedSlate,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      if (showDivider)
        const Divider(height: 1, color: Color(0xFFE5ECEF), indent: 54),
    ],
  );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.loading = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 54,
    width: double.infinity,
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              onPressed == null
                  ? const [Color(0xFF78908F), Color(0xFF78908F)]
                  : const [Color(0xFF003840), Color(0xFF007568)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow:
            onPressed == null
                ? const []
                : const [
                  BoxShadow(
                    color: Color(0x22003840),
                    blurRadius: 12,
                    offset: Offset(0, 5),
                  ),
                ],
      ),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading) ...[
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
              const SizedBox(width: 10),
            ] else if (icon != null) ...[
              Icon(icon, size: 21),
              const SizedBox(width: 9),
            ],
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
