import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/routes/app_routes.dart';
import 'package:payzen_app/screens/wallet/widgets/wallet_activation_progress.dart';

class WalletDetailsScreen extends StatefulWidget {
  const WalletDetailsScreen({super.key});

  @override
  State<WalletDetailsScreen> createState() => _WalletDetailsScreenState();
}

class _WalletDetailsScreenState extends State<WalletDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _parent;
  String? _maritalStatus;
  String? _occupation;
  String? _income;
  String? _nominee;
  bool _hasDisability = false;
  bool _truthConfirmed = true;
  bool _updatesConsent = true;

  void _confirm() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (!_truthConfirmed || !_updatesConsent) {
      Get.snackbar(
        'Confirm both statements',
        'Please accept both confirmations to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.deepTeal,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    Get.toNamed(AppRoutes.walletAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppBar(
        backgroundColor: AppColors.warmIvory,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 46,
        leading: IconButton(
          onPressed: Get.back,
          tooltip: 'Back',
          icon: const Icon(
            LucideIcons.arrowLeft,
            color: AppColors.deepNavyText,
            size: 22,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxHeight < 760;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 3, 22, 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text.rich(
                          TextSpan(
                            style: GoogleFonts.inter(
                              color: AppColors.deepNavyText,
                              fontSize: compact ? 24 : 28,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                            children: const [
                              TextSpan(text: 'Activate '),
                              TextSpan(
                                text: 'PayZen',
                                style: TextStyle(color: Color(0xFF009384)),
                              ),
                              TextSpan(text: ' Wallet'),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: compact ? 16 : 22),
                        _ActivationProgress(isCompact: compact),
                        SizedBox(height: compact ? 18 : 26),
                        Text(
                          'Personal details',
                          style: GoogleFonts.inter(
                            color: AppColors.deepNavyText,
                            fontSize: compact ? 19 : 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: compact ? 12 : 16),
                        _DetailsDropdown(
                          label: 'Parent details',
                          hint: 'Select parent',
                          icon: LucideIcons.users,
                          value: _parent,
                          options: const ['Father', 'Mother'],
                          compact: compact,
                          onChanged: (value) => setState(() => _parent = value),
                        ),
                        SizedBox(height: compact ? 10 : 14),
                        _DetailsDropdown(
                          label: 'Marital status',
                          hint: 'Select marital status',
                          icon: LucideIcons.heart,
                          value: _maritalStatus,
                          options: const ['Unmarried', 'Married', 'Others'],
                          compact: compact,
                          onChanged:
                              (value) => setState(() => _maritalStatus = value),
                        ),
                        SizedBox(height: compact ? 10 : 14),
                        _DetailsDropdown(
                          label: 'Occupation type',
                          hint: 'Select occupation type',
                          icon: LucideIcons.briefcase,
                          value: _occupation,
                          options: const [
                            'Salaried',
                            'Self-employed',
                            'Student',
                            'Homemaker',
                            'Retired',
                            'Other',
                          ],
                          compact: compact,
                          onChanged:
                              (value) => setState(() => _occupation = value),
                        ),
                        SizedBox(height: compact ? 10 : 14),
                        _DetailsDropdown(
                          label: 'Annual income',
                          hint: 'Select annual income',
                          icon: LucideIcons.coins,
                          value: _income,
                          options: const [
                            'Below ₹1 lakh',
                            '₹1–5 lakh',
                            '₹5–10 lakh',
                            'Above ₹10 lakh',
                          ],
                          compact: compact,
                          onChanged: (value) => setState(() => _income = value),
                        ),
                        SizedBox(height: compact ? 10 : 14),
                        _DetailsDropdown(
                          label: 'Nominee',
                          optional: true,
                          hint: 'Select nominee',
                          icon: LucideIcons.users,
                          value: _nominee,
                          options: const [
                            'None',
                            'Spouse',
                            'Daughter',
                            'Son',
                            'Father',
                            'Mother',
                            'Sibling',
                          ],
                          compact: compact,
                          onChanged:
                              (value) => setState(() => _nominee = value),
                        ),
                        SizedBox(height: compact ? 14 : 18),
                        Text(
                          'Are you a person with physical disability?',
                          style: GoogleFonts.inter(
                            color: AppColors.deepNavyText,
                            fontSize: compact ? 15 : 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _YesNoOption(
                              label: 'Yes',
                              selected: _hasDisability,
                              compact: compact,
                              onTap:
                                  () => setState(() => _hasDisability = true),
                            ),
                            SizedBox(width: compact ? 34 : 56),
                            _YesNoOption(
                              label: 'No',
                              selected: !_hasDisability,
                              compact: compact,
                              onTap:
                                  () => setState(() => _hasDisability = false),
                            ),
                          ],
                        ),
                        SizedBox(height: compact ? 8 : 12),
                        _ConsentRow(
                          value: _truthConfirmed,
                          compact: compact,
                          text:
                              'I confirm that the information provided is true, and I am not a U.S. person or a resident of any other jurisdiction.',
                          onChanged:
                              (value) =>
                                  setState(() => _truthConfirmed = value),
                        ),
                        SizedBox(height: compact ? 6 : 10),
                        _ConsentRow(
                          value: _updatesConsent,
                          compact: compact,
                          text:
                              'I consent to my personal information being used for wallet activation and to receive account-related updates from PayZen.',
                          onChanged:
                              (value) =>
                                  setState(() => _updatesConsent = value),
                        ),
                        SizedBox(height: compact ? 12 : 20),
                        SizedBox(
                          height: compact ? 52 : 58,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF003840), Color(0xFF007568)],
                              ),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: FilledButton(
                              onPressed: _confirm,
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Confirm & Proceed',
                                    style: GoogleFonts.inter(
                                      fontSize: compact ? 17 : 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Icon(
                                    LucideIcons.arrowRight,
                                    size: compact ? 21 : 24,
                                  ),
                                ],
                              ),
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
}

class _DetailsDropdown extends StatefulWidget {
  const _DetailsDropdown({
    required this.label,
    required this.hint,
    required this.icon,
    required this.value,
    required this.options,
    required this.compact,
    required this.onChanged,
    this.optional = false,
  });

  final String label;
  final String hint;
  final IconData icon;
  final String? value;
  final List<String> options;
  final bool compact;
  final ValueChanged<String?> onChanged;
  final bool optional;

  @override
  State<_DetailsDropdown> createState() => _DetailsDropdownState();
}

class _DetailsDropdownState extends State<_DetailsDropdown>
    with SingleTickerProviderStateMixin {
  final _fieldKey = GlobalKey();
  final _layerLink = LayerLink();
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 190),
  );
  OverlayEntry? _menuEntry;

  @override
  void dispose() {
    _menuEntry?.remove();
    _animationController.dispose();
    super.dispose();
  }

  void _closeMenu() {
    final entry = _menuEntry;
    if (entry == null) return;
    setState(() => _menuEntry = null);
    _animationController.reverse().whenComplete(entry.remove);
  }

  Future<void> _openMenu(FormFieldState<String> fieldState) async {
    if (_menuEntry != null) {
      _closeMenu();
      return;
    }

    final fieldContext = _fieldKey.currentContext;
    if (fieldContext == null) return;
    await Scrollable.ensureVisible(
      fieldContext,
      alignment: 0.2,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
    );
    if (!mounted || _menuEntry != null) return;

    final renderBox =
        _fieldKey.currentContext!.findRenderObject()! as RenderBox;
    final overlay = Overlay.of(context);
    final overlayBox = overlay.context.findRenderObject()! as RenderBox;
    final fieldPosition = renderBox.localToGlobal(
      Offset.zero,
      ancestor: overlayBox,
    );
    final menuHeight =
        (overlayBox.size.height - fieldPosition.dy - renderBox.size.height - 16)
            .clamp(120.0, 320.0)
            .toDouble();

    final entry = OverlayEntry(
      builder:
          (overlayContext) => Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _closeMenu,
                  child: const ColoredBox(color: Colors.transparent),
                ),
              ),
              CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, renderBox.size.height + 6),
                child: SizedBox(
                  width: renderBox.size.width,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder:
                        (context, child) => Opacity(
                          opacity: _animationController.value,
                          child: Transform.scale(
                            scale: 0.96 + (_animationController.value * 0.04),
                            alignment: Alignment.topCenter,
                            child: child,
                          ),
                        ),
                    child: Material(
                      color: AppColors.pureWhite,
                      elevation: 12,
                      shadowColor: const Color(0x26061C2B),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                        side: const BorderSide(color: Color(0xFFE3E7E9)),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: menuHeight),
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          shrinkWrap: true,
                          itemCount: widget.options.length,
                          separatorBuilder:
                              (_, __) => const Divider(
                                height: 1,
                                indent: 16,
                                endIndent: 16,
                                color: Color(0xFFF0F2F3),
                              ),
                          itemBuilder: (context, index) {
                            final option = widget.options[index];
                            final selected = fieldState.value == option;
                            return InkWell(
                              onTap: () {
                                fieldState.didChange(option);
                                widget.onChanged(option);
                                _closeMenu();
                              },
                              child: SizedBox(
                                height: 48,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          option,
                                          style: GoogleFonts.inter(
                                            color: AppColors.deepNavyText,
                                            fontSize: 15,
                                            fontWeight:
                                                selected
                                                    ? FontWeight.w700
                                                    : FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      if (selected)
                                        const Icon(
                                          LucideIcons.check,
                                          size: 18,
                                          color: Color(0xFF008774),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
    );

    setState(() => _menuEntry = entry);
    overlay.insert(entry);
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.value,
      validator:
          widget.optional
              ? null
              : (selection) =>
                  selection == null
                      ? 'Select ${widget.label.toLowerCase()}'
                      : null,
      builder:
          (fieldState) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.label,
                    style: GoogleFonts.inter(
                      color: AppColors.deepNavyText,
                      fontSize: widget.compact ? 15 : 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (widget.optional) ...[
                    const SizedBox(width: 5),
                    Text(
                      '(optional)',
                      style: GoogleFonts.inter(
                        color: AppColors.deepNavyText,
                        fontSize: widget.compact ? 14 : 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(LucideIcons.info, size: 17),
                  ],
                ],
              ),
              const SizedBox(height: 5),
              CompositedTransformTarget(
                link: _layerLink,
                child: GestureDetector(
                  key: _fieldKey,
                  onTap: () => _openMenu(fieldState),
                  child: Container(
                    height: widget.compact ? 46 : 52,
                    padding: const EdgeInsets.only(right: 14),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(
                        color:
                            fieldState.hasError
                                ? AppColors.errorCoral
                                : const Color(0xFFB9BEC2),
                        width: _menuEntry == null ? 1 : 1.4,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 58,
                          child: Row(
                            children: [
                              const SizedBox(width: 14),
                              Icon(
                                widget.icon,
                                size: 21,
                                color: AppColors.deepNavyText,
                              ),
                              const SizedBox(width: 12),
                              Container(
                                width: 1,
                                height: 25,
                                color: const Color(0xFFB9BEC2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            fieldState.value ?? widget.hint,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color:
                                  fieldState.value == null
                                      ? const Color(0xFF5F6870)
                                      : AppColors.deepNavyText,
                              fontSize: widget.compact ? 14 : 16,
                              fontWeight:
                                  fieldState.value == null
                                      ? FontWeight.w400
                                      : FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        AnimatedRotation(
                          turns: _menuEntry == null ? 0 : 0.5,
                          duration: const Duration(milliseconds: 190),
                          curve: Curves.easeInOut,
                          child: const Icon(
                            LucideIcons.chevronDown,
                            color: AppColors.deepNavyText,
                            size: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (fieldState.hasError) ...[
                const SizedBox(height: 5),
                Text(
                  fieldState.errorText!,
                  style: GoogleFonts.inter(
                    color: AppColors.errorCoral,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
    );
  }
}

class _YesNoOption extends StatelessWidget {
  const _YesNoOption({
    required this.label,
    required this.selected,
    required this.compact,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool compact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 24.0 : 30.0;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
        child: Row(
          children: [
            Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      selected
                          ? const Color(0xFF008774)
                          : const Color(0xFF92999E),
                  width: selected ? 2 : 1.5,
                ),
              ),
              child:
                  selected
                      ? Container(
                        width: size * 0.56,
                        height: size * 0.56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF008774),
                        ),
                      )
                      : null,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.inter(
                color: AppColors.deepNavyText,
                fontSize: compact ? 15 : 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConsentRow extends StatelessWidget {
  const _ConsentRow({
    required this.value,
    required this.compact,
    required this.text,
    required this.onChanged,
  });

  final bool value;
  final bool compact;
  final String text;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: compact ? 34 : 42,
            height: compact ? 36 : 42,
            child: Checkbox(
              value: value,
              onChanged: (checked) => onChanged(checked ?? false),
              activeColor: const Color(0xFF008774),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          SizedBox(width: compact ? 6 : 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: compact ? 3 : 4),
              child: Text(
                text,
                style: GoogleFonts.inter(
                  color: AppColors.deepNavyText,
                  fontSize: compact ? 12.5 : 14,
                  height: 1.35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivationProgress extends StatelessWidget {
  const _ActivationProgress({required this.isCompact});

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return WalletActivationProgress(activeStep: 2, compact: isCompact);
  }
}
