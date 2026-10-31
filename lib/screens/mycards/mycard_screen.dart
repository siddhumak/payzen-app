import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/components/custom_appbar.dart';
import 'package:payzen_app/components/custom_drawer.dart';
import 'package:payzen_app/screens/mycards/widgets/action_buttons.dart';
import 'package:payzen_app/screens/mycards/widgets/add_card_widget.dart';
import 'package:payzen_app/screens/mycards/widgets/cards_section.dart';
import 'package:payzen_app/screens/mycards/widgets/deposit_widget.dart';
import 'package:payzen_app/screens/mycards/widgets/transaction_section.dart';
import 'package:payzen_app/screens/mycards/widgets/withdrawal_widget.dart';

class MycardsScreen extends StatefulWidget {
  const MycardsScreen({super.key});

  @override
  State<MycardsScreen> createState() => _MycardsScreenState();
}

class _MycardsScreenState extends State<MycardsScreen> {
  final ScrollController _scrollController = ScrollController();
  int _activeCardIndex = 0;
  bool _showBalance = true;

  final List<Map<String, dynamic>> _cards = [
    {
      'type': 'Premium Credit',
      'bank': 'HDFC Bank',
      'number': '4532 •••• •••• 4321',
      'balance': '₹45,280',
      'expiry': '12/27',
      'logo': 'VISA',
      'cardType': 'PLATINUM',
      'bgColor': [Color(0xFF1E293B), Color(0xFF334155)],
    },
    {
      'type': 'Cashback Credit',
      'bank': 'SBI Card',
      'number': '5412 •••• •••• 8765',
      'balance': '₹12,450',
      'expiry': '08/26',
      'logo': 'MASTERCARD',
      'cardType': 'BLACK',
      'bgColor': [Color(0xFF1E3A8A), Color(0xFF1E40AF)],
    },
    {
      'type': 'PayTM Card',
      'bank': 'PayTM Payments Bank',
      'number': '6011 •••• •••• 1234',
      'balance': '₹8,920',
      'expiry': '03/28',
      'logo': 'PAYTM',
      'cardType': 'CLASSIC',
      'bgColor': [Color(0xFFDC2626), Color(0xFFEF4444)],
    },
    {'type': 'add'},
  ];
  //
  final List<Transaction> transactions = [
    Transaction.fromType(
      id: 1,
      merchant: "Spotify Premium",
      icon: LucideIcons.music,
      amount: "-₹149",
      time: "2:30 PM",
      card: "HDFC ••4321",
      type: "debit",
    ),
    Transaction.fromType(
      id: 2,
      merchant: "Amazon Purchase",
      icon: LucideIcons.shoppingBag,
      amount: "-₹2,450",
      time: "1:15 PM",
      card: "SBI ••8765",
      type: "debit",
    ),
    Transaction.fromType(
      id: 3,
      merchant: "Fuel Payment",
      icon: LucideIcons.car,
      amount: "-₹1,200",
      time: "11:45 AM",
      card: "HDFC ••4321",
      type: "debit",
    ),
    Transaction.fromType(
      id: 4,
      merchant: "Cashback Reward",
      icon: LucideIcons.plus,
      amount: "+₹85",
      time: "10:30 AM",
      card: "SBI ••8765",
      type: "credit",
    ),
    Transaction.fromType(
      id: 5,
      merchant: "Starbucks Coffee",
      icon: LucideIcons.coffee,
      amount: "-₹320",
      time: "9:15 AM",
      card: "PayTM ••1234",
      type: "debit",
    ),
    Transaction.fromType(
      id: 6,
      merchant: "Amazon Purchase",
      icon: LucideIcons.shoppingBag,
      amount: "-₹2,450",
      time: "1:15 PM",
      card: "SBI ••8765",
      type: "debit",
    ),
  ];

  void _scrollToCard(int index) {
    final double offset = index * 320.0;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _activeCardIndex = index;
    });
  }

  void _onScroll() {
    final index = (_scrollController.offset / 320.0).round();
    if (index != _activeCardIndex) {
      setState(() {
        _activeCardIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      drawer: CustomSideDrawer(),
      appBar: CustomeAppbar(title: 'My Cards'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32), // To avoid cutting bottom
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Row(
                  children: [
                    Icon(Icons.credit_card, color: Colors.black),
                    SizedBox(width: 10),
                    Text(
                      'Your Cards',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              // Card List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 210,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _cards.length,
                    itemBuilder: (context, index) {
                      return CardsSection(
                        card: _cards[index],
                        showBalance: _showBalance,
                        onAddTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (_) => AddCardWidget(
                                  onClose: () => Navigator.pop(context),
                                ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Card Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed:
                          _activeCardIndex > 0
                              ? () => _scrollToCard(_activeCardIndex - 1)
                              : null,
                      icon: const Icon(
                        LucideIcons.chevronLeft,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed:
                          _activeCardIndex < _cards.length - 1
                              ? () => _scrollToCard(_activeCardIndex + 1)
                              : null,
                      icon: const Icon(
                        LucideIcons.chevronRight,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Action Buttons
              ActionButtonsRow(
                onDepositTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const DepositWidget(),
                  );
                },
                onWithdrawTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    builder:
                        (context) =>
                            const WithdrawModal(), // or pass props if needed
                  );
                },
              ),

              const SizedBox(height: 24),

              // Transaction Section
              TransactionSection(
                transactions: transactions,
                showBalance: _showBalance,
                onToggleBalance: () {
                  setState(() {
                    _showBalance = !_showBalance;
                  });
                },
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
