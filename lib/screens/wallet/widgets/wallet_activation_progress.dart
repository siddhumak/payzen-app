import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payzen_app/constant/colors.dart';

class WalletActivationProgress extends StatelessWidget {
  const WalletActivationProgress({
    super.key,
    required this.activeStep,
    this.compact = false,
    this.darkBackground = false,
  }) : assert(activeStep >= 0 && activeStep < 5);

  final int activeStep;
  final bool compact;
  final bool darkBackground;

  static const _labels = ['PAN', 'Aadhaar', 'Details', 'Address', 'Video'];

  @override
  Widget build(BuildContext context) {
    final size = compact ? 28.0 : 32.0;
    final labelColor = darkBackground ? Colors.white : AppColors.deepNavyText;
    final inactiveLine =
        darkBackground
            ? Colors.white.withOpacity(0.34)
            : const Color(0xFFD2D9DD);

    return LayoutBuilder(
      builder:
          (context, constraints) => SizedBox(
            height: size + (compact ? 20 : 24),
            child: Stack(
              children: [
                Positioned(
                  left: constraints.maxWidth / 10,
                  right: constraints.maxWidth / 10,
                  top: size / 2,
                  child: Row(
                    children: List.generate(4, (index) {
                      final done = index < activeStep;
                      return Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 260),
                          height: 2,
                          color: done ? AppColors.electricMint : inactiveLine,
                        ),
                      );
                    }),
                  ),
                ),
                Row(
                  children: List.generate(_labels.length, (step) {
                    final complete = step < activeStep;
                    final active = step == activeStep;
                    final filled = complete || active;
                    final circleColor =
                        complete
                            ? AppColors.electricMint
                            : active
                            ? (darkBackground
                                ? AppColors.deepTeal
                                : AppColors.deepTeal)
                            : Colors.transparent;
                    final borderColor =
                        filled
                            ? (darkBackground && active
                                ? AppColors.electricMint
                                : circleColor)
                            : (darkBackground
                                ? Colors.white.withOpacity(0.58)
                                : const Color(0xFFBFC8CE));

                    return Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 260),
                            curve: Curves.easeOutCubic,
                            width: size,
                            height: size,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: circleColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: borderColor,
                                width: 1.5,
                              ),
                              boxShadow:
                                  active
                                      ? [
                                        BoxShadow(
                                          color: AppColors.electricMint
                                              .withOpacity(0.22),
                                          blurRadius: 10,
                                        ),
                                      ]
                                      : const [],
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 180),
                              child:
                                  complete
                                      ? Icon(
                                        Icons.check_rounded,
                                        key: const ValueKey('complete'),
                                        color:
                                            darkBackground
                                                ? AppColors.deepTeal
                                                : Colors.white,
                                        size: compact ? 17 : 19,
                                      )
                                      : Text(
                                        '${step + 1}',
                                        key: ValueKey('step-$step'),
                                        style: GoogleFonts.inter(
                                          color:
                                              filled
                                                  ? Colors.white
                                                  : (darkBackground
                                                      ? Colors.white
                                                      : AppColors.mutedSlate),
                                          fontSize: compact ? 12 : 14,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                            ),
                          ),
                          SizedBox(height: compact ? 4 : 5),
                          Text(
                            _labels[step],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color:
                                  darkBackground
                                      ? labelColor.withOpacity(
                                        active ? 1 : 0.82,
                                      )
                                      : labelColor,
                              fontSize: compact ? 9.5 : 10.5,
                              fontWeight:
                                  active || complete
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
    );
  }
}
