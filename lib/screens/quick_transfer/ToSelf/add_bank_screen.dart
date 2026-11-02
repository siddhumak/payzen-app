import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/screens/quick_transfer/widgets/other_bank_list_section.dart';
import 'package:payzen_app/screens/quick_transfer/widgets/popular_bank_grid.dart';

class AddBankAccountScreen extends StatefulWidget {
  const AddBankAccountScreen({super.key});

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  String searchQuery = '';
  String? selectedBank;
  int _flowStep = 0;
  int _selectedAccountIndex = 0;
  bool _fetchingAccounts = false;
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    setState(() => _flowStep = step);
    if (step == 4 || step == 6) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _confettiController.play();
      });
    }
  }

  final List<Map<String, String>> popularBanks = [
    {
      'id': 'sbi',
      'name': 'State Bank of India',
      'short': 'SBI',
      'color': '#FFFFFF', // ✅ correct
      'logo': 'assets/images/sbi.png',
    },
    {
      'id': 'hdfc',
      'name': 'HDFC Bank',
      'short': 'HDFC',
      'color': '#FFFFFF', // ✅ correct
      'logo': 'assets/images/hdfc.png',
    },
    {
      'id': 'icici',
      'name': 'ICICI Bank',
      'short': 'ICICI',
      'color': '#FFFFFF', // ✅ correct
      'logo': 'assets/images/icici.png',
    },
    {
      'id': 'axis',
      'name': 'Axis Bank',
      'short': 'AXIS',
      'color': '#FFFFFF', // ✅ correct
      'logo': 'assets/images/axis.png',
    },
    {
      'id': 'kotak',
      'name': 'Kotak Mahindra Bank',
      'short': 'KOTAK',
      'color': '#FFFFFF', // ✅ correct
      'logo': 'assets/images/kotak.png',
    },
    {
      'id': 'pnb',
      'name': 'Punjab National Bank',
      'short': 'PNB',
      'color': '#FFFFFF', // ✅ correct
      'logo': 'assets/images/pnb.png',
    },
    {
      'id': 'canara',
      'name': 'Canara Bank',
      'short': 'CANARA',
      'color': '#FFFFFF', // ✅ correct
      'logo': 'assets/images/canara.png',
    },
    {
      'id': 'bob',
      'name': 'Bank of Baroda',
      'short': 'BOB',
      'color': '#FFFFFF', // ✅ correct
      'logo': 'assets/images/bob.png',
    },
  ];

  final List<String> otherBanks = [
    'Union Bank of India',
    'Indian Bank',
    'Central Bank of India',
    'Indian Overseas Bank',
    'UCO Bank',
    'Bank of Maharashtra',
    'Punjab & Sind Bank',
    'IDFC First Bank',
    'Yes Bank',
    'IndusInd Bank',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredBanks =
        popularBanks
            .where(
              (bank) => bank['name']!.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
            )
            .toList();

    final filteredOtherBanks =
        otherBanks
            .where(
              (bank) => bank.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList();

    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_flowStep > 0) {
              setState(() => _flowStep--);
            } else {
              Get.back();
            }
          },
        ),
        title: Text(
          _flowStep == 0 ? 'Link Bank Account' : _stepTitle,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        flexibleSpace: Image.asset(
          'assets/images/header_waves_bg.jpg',
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
        backgroundColor: AppColors.deepTeal,
        foregroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body:
          _flowStep == 0
              ? _bankSelectionStep(filteredBanks, filteredOtherBanks)
              : _buildFlowStep(),
      bottomSheet: _buildBottomAction(),
    );
  }

  Widget _bankSelectionStep(
    List<Map<String, String>> filteredBanks,
    List<String> filteredOtherBanks,
  ) => Stack(
    children: [
      const Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: 156,
        child: Image(
          image: AssetImage('assets/images/header_waves_bg.jpg'),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
      ),
      Positioned.fill(
        top: 72,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
        ),
      ),
      SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 84, 16, 90),
          children: [
            Text(
              'Select your bank',
              style: GoogleFonts.inter(
                color: AppColors.deepNavyText,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.35,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Choose the bank account you want to link for UPI payments.',
              style: GoogleFonts.inter(
                color: AppColors.mutedSlate,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            searchBar(),
            const SizedBox(height: 18),
            PopularBankGrid(
              banks: filteredBanks,
              selectedBank: selectedBank,
              onBankSelected: (bankName) {
                setState(() => selectedBank = bankName);
              },
            ),
            const SizedBox(height: 20),
            if (searchQuery.isEmpty)
              OtherBankList(
                banks: otherBanks,
                selectedBank: selectedBank,
                showViewAll: true,
                onBankSelected: (bank) => setState(() => selectedBank = bank),
              )
            else if (filteredOtherBanks.isNotEmpty)
              OtherBankList(
                banks: filteredOtherBanks,
                selectedBank: selectedBank,
                onBankSelected: (bank) => setState(() => selectedBank = bank),
              ),
          ],
        ),
      ),
    ],
  );

  String get _stepTitle => switch (_flowStep) {
    1 => 'Verify mobile',
    2 => 'Find accounts',
    3 => 'Select account',
    4 => 'Bank linked',
    5 => 'UPI PIN setup',
    _ => 'UPI ready',
  };

  Widget _buildFlowStep() {
    final content = AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: KeyedSubtree(
        key: ValueKey(_flowStep),
        child: switch (_flowStep) {
          1 => _verificationStep(),
          2 => _fetchAccountsStep(),
          3 => _selectAccountStep(),
          4 => _bankLinkedStep(),
          5 => _upiPinSetupStep(),
          _ => _upiReadyStep(),
        },
      ),
    );

    return Stack(
      children: [
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 156,
          child: Image(
            image: AssetImage('assets/images/header_waves_bg.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
        Positioned.fill(
          top: 72,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 84, 20, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _progressCard(),
                const SizedBox(height: 18),
                content,
                const SizedBox(height: 16),
                if (_flowStep < 4 || _flowStep == 5) _previewNotice(),
              ],
            ),
          ),
        ),
        if (_flowStep == 4 || _flowStep == 6)
          Positioned.fill(
            child: IgnorePointer(
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 28,
                maxBlastForce: 18,
                minBlastForce: 7,
                gravity: 0.18,
                emissionFrequency: 0.04,
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
    );
  }

  Widget _progressCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: AppColors.borderLight),
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
          'Step ${_flowStep + 1} of 7',
          style: GoogleFonts.inter(
            color: AppColors.mutedSlate,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: (_flowStep + 1) / 7,
            minHeight: 6,
            backgroundColor: const Color(0xFFE5ECEF),
            color: AppColors.electricMint,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _bankAvatar(size: 38),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                selectedBank ?? 'Choose your bank to continue',
                style: GoogleFonts.inter(
                  color: AppColors.deepNavyText,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(
              Icons.verified_user_outlined,
              color: AppColors.deepTeal,
              size: 19,
            ),
          ],
        ),
      ],
    ),
  );

  Widget _verificationStep() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _stepHeading(
        'Verify your mobile number',
        'We use the SIM registered with your bank to securely discover eligible accounts.',
      ),
      const SizedBox(height: 16),
      _verificationHero(),
      const SizedBox(height: 16),
      _featureCard(
        icon: Icons.sim_card_outlined,
        title: 'SIM verification',
        detail: 'Confirms your number with ${selectedBank ?? 'your bank'}',
      ),
      _featureCard(
        icon: Icons.verified_user_outlined,
        title: 'Secure & instant',
        detail: 'Standard UPI bank verification on this device',
      ),
      _featureCard(
        icon: Icons.lock_outline,
        title: 'Your data stays safe',
        detail: 'Bank details are handled by the UPI provider',
      ),
    ],
  );

  Widget _verificationHero() => ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: SizedBox(
      height: 132,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/header_waves_bg.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.bottomRight,
          ),
          ColoredBox(color: AppColors.deepTeal.withOpacity(0.38)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 62,
                      height: 62,
                      padding: const EdgeInsets.all(11),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: _bankLogoImage(fallbackSize: 30),
                    ),
                    Positioned(
                      right: -5,
                      bottom: -3,
                      child: Container(
                        width: 27,
                        height: 27,
                        decoration: const BoxDecoration(
                          color: AppColors.electricMint,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.sim_card_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Secure SIM verification',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Confirm your registered mobile on this device.',
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.88),
                          fontSize: 12,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _fetchAccountsStep() => Container(
    padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
    decoration: BoxDecoration(
      color: AppColors.pureWhite,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: AppColors.borderLight),
      boxShadow: const [
        BoxShadow(
          color: AppColors.cardShadow,
          blurRadius: 14,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child:
              _fetchingAccounts
                  ? const SizedBox(
                    key: ValueKey('fetching'),
                    width: 68,
                    height: 68,
                    child: CircularProgressIndicator(
                      color: AppColors.electricMint,
                      strokeWidth: 5,
                    ),
                  )
                  : Container(
                    key: const ValueKey('search'),
                    width: 68,
                    height: 68,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEAF8F4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance_outlined,
                      color: AppColors.deepTeal,
                      size: 32,
                    ),
                  ),
        ),
        const SizedBox(height: 18),
        Text(
          _fetchingAccounts
              ? 'Searching for accounts…'
              : 'Find eligible accounts',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: AppColors.deepNavyText,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'The UPI provider checks for accounts linked to your verified mobile number at ${selectedBank ?? 'your bank'}.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: AppColors.mutedSlate,
            fontSize: 14,
            height: 1.45,
          ),
        ),
      ],
    ),
  );

  Widget _selectAccountStep() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _stepHeading(
        'Select your bank account',
        'Choose the account you want to link for UPI payments.',
      ),
      const SizedBox(height: 12),
      _sampleAccountTile(0, '•••• 1234', 'Savings account'),
      const SizedBox(height: 10),
      _sampleAccountTile(1, '•••• 5678', 'Savings account'),
      const SizedBox(height: 10),
      Text(
        'Sample accounts shown for UI preview',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          color: AppColors.mutedSlate,
          fontSize: 12,
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  );

  Widget _sampleAccountTile(int index, String account, String type) {
    final selected = _selectedAccountIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFEAF8F4) : AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected ? AppColors.electricMint : AppColors.borderLight,
          width: selected ? 1.6 : 1,
        ),
        boxShadow:
            selected
                ? const [
                  BoxShadow(
                    color: Color(0x1A19C6AE),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ]
                : const [],
      ),
      child: InkWell(
        onTap: () => setState(() => _selectedAccountIndex = index),
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF8F4),
                  shape: BoxShape.circle,
                ),
                child: _bankLogoImage(fallbackSize: 23),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedBank ?? 'Bank account',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w800,
                        color: AppColors.deepNavyText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '$type  $account',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.mutedSlate,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: Icon(
                  selected ? Icons.check_circle : Icons.radio_button_unchecked,
                  key: ValueKey(selected),
                  color: selected ? AppColors.deepTeal : AppColors.mutedSlate,
                  size: 23,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bankLinkedStep() => Column(
    children: [
      _successPanel(
        title: 'Bank account linked!',
        subtitle:
            'Your ${selectedBank ?? 'bank'} account is linked with PayZen.',
        account: _accountLabel,
        actionLabel: 'Continue to UPI setup',
        onAction: () => _goToStep(5),
        secondaryLabel: 'Set up later',
        onSecondary: () => Get.offNamed('/main'),
      ),
      const SizedBox(height: 8),
      Text(
        'Preview only — the bank provider must confirm the real link.',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(color: AppColors.mutedSlate, fontSize: 12),
      ),
    ],
  );

  Widget _upiPinSetupStep() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _stepHeading(
        'Set up your UPI PIN',
        'Optional: continue to your bank’s secure flow to set or verify your UPI PIN.',
      ),
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderLight),
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
            Row(
              children: [
                const Icon(
                  Icons.credit_card_outlined,
                  color: AppColors.deepTeal,
                ),
                const SizedBox(width: 8),
                Text(
                  'Debit card details',
                  style: GoogleFonts.inter(
                    color: AppColors.deepNavyText,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _securePlaceholderField(Icons.credit_card, 'Last 6 digits of card'),
            const SizedBox(height: 10),
            _securePlaceholderField(Icons.calendar_month_outlined, 'MM / YY'),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(
                  Icons.lock_outline,
                  color: AppColors.deepTeal,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Card verification and PIN setup happen in your bank’s secure UPI flow.',
                    style: GoogleFonts.inter(
                      color: AppColors.mutedSlate,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 14),
      OutlinedButton.icon(
        onPressed: () => _goToStep(6),
        icon: const Icon(Icons.visibility_outlined),
        label: const Text('Preview UPI ready screen'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.deepTeal,
          side: const BorderSide(color: AppColors.electricMint),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
      ),
      TextButton(
        onPressed: () => Get.offNamed('/main'),
        child: Text(
          'Skip for now',
          style: GoogleFonts.inter(
            color: AppColors.deepTeal,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );

  Widget _securePlaceholderField(IconData icon, String hint) => TextField(
    enabled: false,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, size: 19, color: AppColors.deepTeal),
      hintText: hint,
      hintStyle: GoogleFonts.inter(color: AppColors.mutedSlate, fontSize: 14),
      filled: true,
      fillColor: AppColors.warmIvory,
      contentPadding: const EdgeInsets.symmetric(vertical: 13),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
    ),
  );

  Widget _upiReadyStep() => Column(
    children: [
      _successPanel(
        title: 'UPI ready!',
        subtitle:
            'Your UPI PIN setup is complete. You can now make UPI payments with PayZen.',
        account: _accountLabel,
        actionLabel: 'Start using PayZen',
        onAction: () => Get.offNamed('/main'),
      ),
      const SizedBox(height: 10),
      Text(
        'Preview only — final UPI readiness depends on confirmation from your bank.',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(color: AppColors.mutedSlate, fontSize: 12),
      ),
    ],
  );

  String get _accountLabel =>
      _selectedAccountIndex == 0 ? '•••• 1234' : '•••• 5678';

  String? get _selectedBankLogo {
    for (final bank in popularBanks) {
      if (bank['name'] == selectedBank) return bank['logo'];
    }
    return null;
  }

  Widget _bankAvatar({double size = 46}) => Container(
    width: size,
    height: size,
    padding: EdgeInsets.all(size * 0.19),
    decoration: const BoxDecoration(
      color: Color(0xFFEAF8F4),
      shape: BoxShape.circle,
    ),
    child: _bankLogoImage(fallbackSize: size * 0.6),
  );

  Widget _bankLogoImage({required double fallbackSize}) {
    final logo = _selectedBankLogo;
    if (logo == null) {
      return Icon(
        Icons.account_balance_rounded,
        color: AppColors.deepTeal,
        size: fallbackSize,
      );
    }
    return Image.asset(
      logo,
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) => Icon(
            Icons.account_balance_rounded,
            color: AppColors.deepTeal,
            size: fallbackSize,
          ),
    );
  }

  Widget _successPanel({
    required String title,
    required String subtitle,
    required String account,
    required String actionLabel,
    required VoidCallback onAction,
    String? secondaryLabel,
    VoidCallback? onSecondary,
  }) => Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
    decoration: BoxDecoration(
      color: AppColors.pureWhite,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: const Color(0xFFD8EEE8)),
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
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE4F8F1),
              border: Border.all(color: AppColors.electricMint, width: 2),
              boxShadow: const [
                BoxShadow(color: Color(0x2219C6AE), blurRadius: 18),
              ],
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.deepTeal,
              size: 48,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: AppColors.deepNavyText,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: AppColors.mutedSlate,
            fontSize: 14,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: const Color(0xFFF1FBF7),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: _bankLogoImage(fallbackSize: 23),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedBank ?? 'Bank account',
                      style: GoogleFonts.inter(
                        color: AppColors.deepNavyText,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'A/c No.  $account',
                      style: GoogleFonts.inter(
                        color: AppColors.mutedSlate,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9F6E7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.successGreen,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Linked',
                      style: GoogleFonts.inter(
                        color: AppColors.successGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.deepTeal, Color(0xFF087E78)],
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    actionLabel,
                    style: GoogleFonts.inter(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 19),
                ],
              ),
            ),
          ),
        ),
        if (secondaryLabel != null) ...[
          const SizedBox(height: 8),
          TextButton(
            onPressed: onSecondary,
            child: Text(
              secondaryLabel,
              style: GoogleFonts.inter(
                color: AppColors.deepTeal,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    ),
  );

  Widget _stepHeading(String title, String subtitle) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.inter(
          color: AppColors.deepNavyText,
          fontSize: 21,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.35,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        subtitle,
        style: GoogleFonts.inter(
          color: AppColors.mutedSlate,
          fontSize: 14,
          height: 1.45,
        ),
      ),
    ],
  );

  Widget _featureCard({
    required IconData icon,
    required String title,
    required String detail,
  }) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    decoration: BoxDecoration(
      color: AppColors.pureWhite,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.borderLight),
    ),
    child: Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF8F4),
            borderRadius: BorderRadius.circular(13),
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
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                detail,
                style: GoogleFonts.inter(
                  color: AppColors.mutedSlate,
                  fontSize: 12,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.check_circle, color: AppColors.successGreen, size: 19),
      ],
    ),
  );

  Widget _previewNotice() => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF7E6),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      'UI preview only. SIM verification, account discovery, PIN status, and linking require a supported UPI provider integration.',
      style: GoogleFonts.inter(
        color: const Color(0xFF775A20),
        fontSize: 12,
        height: 1.4,
      ),
    ),
  );

  Widget? _buildBottomAction() {
    if (_flowStep == 0) {
      if (selectedBank == null) return null;
      return _bottomButton('Continue with $selectedBank', () => _goToStep(1));
    }
    if (_flowStep == 1) {
      return _bottomButton('Verify with SIM', () => _goToStep(2));
    }
    if (_flowStep == 2) {
      return _bottomButton(
        _fetchingAccounts ? 'Searching…' : 'Fetch accounts (preview)',
        _fetchingAccounts
            ? null
            : () async {
              setState(() => _fetchingAccounts = true);
              await Future<void>.delayed(const Duration(milliseconds: 900));
              if (mounted) {
                setState(() => _fetchingAccounts = false);
                _goToStep(3);
              }
            },
      );
    }
    if (_flowStep == 3) {
      return _bottomButton('Link selected account', () => _goToStep(4));
    }
    // The linked, optional PIN setup, and UPI ready screens own their actions.
    return null;
  }

  Widget _bottomButton(String label, VoidCallback? onPressed) => Container(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
    decoration: BoxDecoration(
      color: AppColors.pureWhite,
      border: const Border(top: BorderSide(color: AppColors.borderLight)),
      boxShadow: const [
        BoxShadow(
          color: AppColors.cardShadow,
          blurRadius: 14,
          offset: Offset(0, -3),
        ),
      ],
    ),
    child: SafeArea(
      top: false,
      child: SizedBox(
        height: 54,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  onPressed == null
                      ? const [Color(0xFF8BA6A5), Color(0xFF8BA6A5)]
                      : const [AppColors.deepTeal, Color(0xFF087E78)],
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 9),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 19,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Widget searchBar() {
    return TextField(
      onChanged: (value) => setState(() => searchQuery = value),
      style: GoogleFonts.inter(color: AppColors.deepNavyText, fontSize: 15),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: AppColors.deepTeal),
        hintText: 'Search for your bank',
        hintStyle: GoogleFonts.inter(color: AppColors.mutedSlate, fontSize: 14),
        filled: true,
        fillColor: AppColors.pureWhite,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.electricMint,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
