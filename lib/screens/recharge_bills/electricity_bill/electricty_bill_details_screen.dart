// Flutter version of the ElectricityBillDetails React Component

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ElectricityBillDetailsScreen extends StatefulWidget {
  const ElectricityBillDetailsScreen({super.key});

  @override
  State<ElectricityBillDetailsScreen> createState() =>
      _ElectricityBillDetailsScreenState();
}

class _ElectricityBillDetailsScreenState
    extends State<ElectricityBillDetailsScreen> {
  Map<String, dynamic>? biller;
  String? accountNumber;
  String? tag;
  bool isLoading = true;
  Map<String, dynamic>? billData;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    biller = args['biller'];
    accountNumber = args['accountNumber'];
    tag = args['tag'];

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        billData = {
          'consumerName': 'Siddesh Rajesh Dhumak',
          'consumerNumber': accountNumber ?? '123456789',
          'dueDate': '15 Aug 2025',
          'billDate': '10 Jul 2025',
          'currentAmount': 2847.50,
          'previousAmount': 2564.30,
          'units': 285,
          'tariff': 'Domestic',
          'status': 'Unpaid',
          'lateCharges': 50.00,
          'address': 'Flat 302, Sunshine Apartments, Pune - 411001',
        };
        isLoading = false;
      });
    });
  }

  void handlePayNow() {
    Get.toNamed(
      '/electricity-payment',
      arguments: {'biller': biller, 'billData': billData, 'tag': tag},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? _buildLoadingView() : _buildBillDetailsView(),
    );
  }

  Widget _buildLoadingView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.deepPurple,
                ),
              ),
              Icon(
                LucideIcons.zap,
                color: Colors.deepPurple.shade400,
                size: 26,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Fetching your bill',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please wait while we retrieve your latest electricity bill details...',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildBillDetailsView() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft),
            onPressed: () => Get.back(),
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepPurple.shade50,
                child: Text(biller?['logo'] ?? '⚡'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bill Details',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    biller?['name'] ?? '',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Status card
                Card(
                  color: Colors.orange.shade50,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange.shade100,
                      child: const Icon(
                        LucideIcons.clock,
                        color: Colors.deepOrange,
                      ),
                    ),
                    title: const Text(
                      'Payment Due',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                    subtitle: Text(
                      'Due date: ${billData?['dueDate']}',
                      style: const TextStyle(color: Colors.orange),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange.shade100,
                      ),
                      child: Text(
                        billData?['status'],
                        style: const TextStyle(color: Colors.deepOrange),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Amount Card
                Card(
                  color: Colors.deepPurple,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Total Amount Due',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₹${billData?['currentAmount']}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Previous: ₹${billData?['previousAmount']} | Late Charges: ₹${billData?['lateCharges']}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _infoTile(
                              'Units Consumed',
                              '${billData?['units']} kWh',
                            ),
                            _infoTile('Tariff Type', billData?['tariff']),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Consumer details
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              LucideIcons.checkCircle,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Consumer Details',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        _detailRow('Name', billData?['consumerName']),
                        _detailRow(
                          'Consumer Number',
                          billData?['consumerNumber'],
                        ),
                        _detailRow('Bill Date', billData?['billDate']),
                        _detailRow('Address', billData?['address']),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Buttons
                ElevatedButton(
                  onPressed: handlePayNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Pay Now - ₹${billData?['currentAmount']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('View Different Bill'),
                ),
                const SizedBox(height: 16),

                // Security note
                Card(
                  color: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          LucideIcons.shield,
                          color: Colors.deepPurple,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Secure Payment',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Your payment is protected by 256-bit SSL encryption and processed through secure payment gateways.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
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
      ],
    );
  }

  Widget _detailRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Flexible(child: Text(value ?? '-', textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
