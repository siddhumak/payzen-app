import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:m2online_recharge_app/components/custom_appbar.dart';
import 'package:m2online_recharge_app/components/custom_drawer.dart';
import 'package:m2online_recharge_app/screens/wallet/widgets/offers_rewards_section.dart';
import 'package:m2online_recharge_app/screens/wallet/widgets/quick_action_section.dart';
import 'package:m2online_recharge_app/screens/wallet/widgets/recent_transaction_section.dart';
import 'package:m2online_recharge_app/screens/wallet/widgets/wallet_card.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool showBalance = true;

  @override
  Widget build(BuildContext context) {
    final quickActions = [
      {
        'icon': LucideIcons.plus,
        'label': 'Add Money',
        'gradient': [Colors.green, Colors.teal],
      },
      {
        'icon': LucideIcons.qrCode,
        'label': 'Scan QR',
        'gradient': [Colors.blue, Colors.cyan],
      },
      {
        'icon': LucideIcons.send,
        'label': 'Send',
        'gradient': [Colors.purple, Colors.deepPurple],
      },
      {
        'icon': LucideIcons.gift,
        'label': 'Passbook',
        'gradient': [Colors.orange, Colors.red],
      },
    ];

    final recentTransactions = [
      {
        'icon': '🍕',
        'name': 'Swiggy',
        'amount': '-₹245',
        'time': '2:30 PM',
        'type': 'Food',
        'positive': false,
      },
      {
        'icon': '👤',
        'name': 'Rahul Kumar',
        'amount': '+₹500',
        'time': '11:45 AM',
        'type': 'Transfer',
        'positive': true,
      },
      {
        'icon': '🛒',
        'name': 'Amazon Pay',
        'amount': '-₹1,299',
        'time': '9:20 AM',
        'type': 'Shopping',
        'positive': false,
      },
      {
        'icon': '🎁',
        'name': 'Cashback Reward',
        'amount': '+₹25',
        'time': 'Yesterday',
        'type': 'Reward',
        'positive': true,
      },
    ];

    final offers = [
      {
        'title': 'Get ₹100 Cashback',
        'subtitle': 'Add ₹1000 & get ₹100 back',
        'icon': LucideIcons.sparkles,
        'gradient': [Colors.red, Colors.pink],
      },
      {
        'title': 'UPI Rewards',
        'subtitle': 'Earn 1% on every UPI payment',
        'icon': LucideIcons.zap,
        'gradient': [Colors.blue, Colors.cyan],
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      drawer: CustomSideDrawer(),
      appBar: CustomeAppbar(title: 'Wallet'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Wallet Card
            WalletCard(),
            const SizedBox(height: 26),
            //Quick Actions Section
            QuickActionsSection(quickActions: quickActions),
            const SizedBox(height: 26),
            //Offers & Rewards Section
            OffersRewardsSection(offers: offers),
            const SizedBox(height: 12),
            //Recent Transactions Section
            RecentTransactionsSection(recentTransactions: recentTransactions),
          ],
        ),
      ),
    );
  }
}
