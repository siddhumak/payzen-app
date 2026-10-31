import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2online_recharge_app/components/info_card.dart';
import 'package:m2online_recharge_app/constant/colors.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/other_bank_list_section.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/popular_bank_grid.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/prev_linked_accounts_section.dart';
import 'package:m2online_recharge_app/utils/custom_button.dart';

class AddBankAccountScreen extends StatefulWidget {
  const AddBankAccountScreen({super.key});

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  String searchQuery = '';
  String? selectedBank;

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

  final List<Map<String, String>> linkedAccounts = [
    {
      'id': '1',
      'bank': 'HDFC Bank',
      'accountNumber': '****1234',
      'upiId': 'user@hdfcbank',
    },
    {
      'id': '2',
      'bank': 'SBI',
      'accountNumber': '****5678',
      'upiId': 'user@sbi',
    },
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
      backgroundColor: const Color(0xFFF5F8FF),
      //appbar
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed('/main'),
        ),
        title: Text(
          "Add Bank Account",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
          children: [
            InfoCard(
              icon: Icons.shield,
              iconColor: Color(0xFF2563EB),
              iconBackgroundColor: Color(0xFFDBEAFE),
              message:
                  'Securely link your bank account to UPI. Auto-detection supported.',
              textColor: Color(0xFF1D4ED8),
              gradientColors: [Color(0xFFEBF4FF), Color(0xFFE0E7FF)],
            ),

            const SizedBox(height: 16),
            searchBar(),
            const SizedBox(height: 16),
            //Fetch My Linked Bank Accounts
            const SizedBox(height: 6),
            CustomButton(
              label: 'Fetch My Linked Bank Accounts',
              onPressed: () {},
              icon: Icons.account_balance,
              backgroundColor: AppColors.primary,
            ),
            const SizedBox(height: 16),
            PopularBankGrid(
              banks: popularBanks,
              selectedBank: selectedBank,
              onBankSelected: (bankName) {
                setState(() => selectedBank = bankName);
              },
            ),
            const SizedBox(height: 20),
            if (searchQuery.isEmpty)
              OtherBankList(
                banks: otherBanks.take(5).toList(),
                showViewAll: true,
                onBankSelected: (bank) => setState(() => selectedBank = bank),
              )
            else if (filteredOtherBanks.isNotEmpty)
              OtherBankList(
                banks: filteredOtherBanks,
                onBankSelected: (bank) => setState(() => selectedBank = bank),
              ),
            const SizedBox(height: 20),
            if (linkedAccounts.isNotEmpty && searchQuery.isEmpty)
              PreviouslyLinkedAccounts(accounts: linkedAccounts),
          ],
        ),
      ),
      bottomSheet:
          selectedBank != null
              ? Container(
                padding: const EdgeInsets.all(16),
                color: Color(0xFFF5F8FF),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.account_balance, color: Colors.white),
                  label: Text(
                    'Proceed with ${selectedBank!.length > 20 ? '${selectedBank!.substring(0, 20)}...' : selectedBank}',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              )
              : null,
    );
  }

  Widget searchBar() {
    return TextField(
      onChanged: (value) => setState(() => searchQuery = value),
      style: TextStyle(color: AppColors.primary),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search for your bank',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
