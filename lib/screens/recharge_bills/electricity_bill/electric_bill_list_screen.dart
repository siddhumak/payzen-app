import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2online_recharge_app/constant/colors.dart';

class ElectricityBillListScreen extends StatefulWidget {
  const ElectricityBillListScreen({super.key});

  @override
  State<ElectricityBillListScreen> createState() =>
      _ElectricityBillListScreenState();
}

class _ElectricityBillListScreenState extends State<ElectricityBillListScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> billers = [
    {
      'id': 1,
      'name': 'Adani Electricity',
      'state': 'Maharashtra',
      'logo': '⚡',
      'popular': true,
    },
    {
      'id': 2,
      'name': 'Brihan Mumbai Electricity (BEST)',
      'state': 'Maharashtra',
      'logo': '🏢',
      'popular': true,
    },
    {
      'id': 3,
      'name': 'Mahavitaran - Maharashtra (MSEDCL)',
      'state': 'Maharashtra',
      'logo': '🏭',
      'popular': true,
    },
    {
      'id': 4,
      'name': 'Tata Power',
      'state': 'Maharashtra',
      'logo': '⚡',
      'popular': false,
    },
    {
      'id': 5,
      'name': 'Reliance Energy',
      'state': 'Maharashtra',
      'logo': '🔋',
      'popular': false,
    },
  ];

  final List<Map<String, dynamic>> recentBills = [];

  List<Map<String, dynamic>> get filteredBillers {
    String query = _searchController.text.toLowerCase();
    return billers
        .where(
          (biller) =>
              biller['name'].toLowerCase().contains(query) ||
              biller['state'].toLowerCase().contains(query),
        )
        .toList();
  }

  void _handleBillerSelect(Map<String, dynamic> biller) {
    bool alreadyExists = recentBills.any(
      (b) => b['fullName'] == biller['name'],
    );

    if (!alreadyExists) {
      setState(() {
        recentBills.insert(0, {
          'id': DateTime.now().millisecondsSinceEpoch,
          'provider': biller['name'],
          'fullName': biller['name'],
          'logo': biller['logo'],
          'lastPayment': 'Not Paid Yet',
          'status': 'Selected',
          'color': Colors.orange,
        });
      });
    }

    Navigator.pushNamed(context, '/billEntry', arguments: biller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed('/main');
          },
        ),
        title: Text(
          "Pay Electricity Bill",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Location Row
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: const Text(
                      "Maharashtra",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Change",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Conditional: Your Bills section
                    if (recentBills.isNotEmpty) ...[
                      Text(
                        "Your Bills",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 10),
                      for (var bill in recentBills)
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: bill['color'].withOpacity(0.1),
                              child: Text(bill['logo']),
                            ),
                            title: Text(
                              bill['fullName'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              "${bill['status']} on ${bill['lastPayment']}",
                              style: TextStyle(color: bill['color']),
                            ),
                            trailing: TextButton.icon(
                              onPressed:
                                  () => _handleBillerSelect({
                                    'name': bill['fullName'],
                                    'logo': bill['logo'],
                                  }),
                              icon: const Icon(Icons.chevron_right, size: 18),
                              label: const Text("Continue"),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                    ],

                    // Always show search bar and billers
                    Text(
                      "Add New Electricity Bill",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search by biller name or state',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "Maharashtra",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),

                    for (var biller in filteredBillers)
                      GestureDetector(
                        onTap: () => _handleBillerSelect(biller),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue.withOpacity(0.1),
                                  child: Text(biller['logo']),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        biller['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      if (biller['popular'])
                                        Container(
                                          margin: const EdgeInsets.only(top: 4),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: const Text(
                                            "Popular",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey,
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
          ],
        ),
      ),
    );
  }
}
