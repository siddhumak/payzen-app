import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FinanceServiceSection extends StatelessWidget {
  const FinanceServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_ServiceItem> services = [
      _ServiceItem(
        icon: LucideIcons.banknote,
        label: "Get Loan",
        color: const Color(0xFFDBEAFE),
      ), // bg-blue-100
      _ServiceItem(
        icon: LucideIcons.coins,
        label: "Save in Gold",
        color: const Color(0xFFFEF9C3),
      ), // bg-yellow-100
      _ServiceItem(
        icon: LucideIcons.creditCard,
        label: "Get Credit Card",
        color: const Color(0xFFE9D5FF),
      ), // bg-purple-100
      _ServiceItem(
        icon: LucideIcons.trendingUp,
        label: "Invest in Mutual Fund",
        color: const Color(0xFFD1FAE5),
      ), // bg-green-100
      _ServiceItem(
        icon: LucideIcons.barChart3,
        label: "Invest in Stocks",
        color: const Color(0xFFD1FAE5),
      ), // bg-green-100
      _ServiceItem(
        icon: LucideIcons.heart,
        label: "Get Health Insurance",
        color: const Color(0xFFFECACA),
      ), // bg-red-100
      _ServiceItem(
        icon: LucideIcons.car,
        label: "Insure your Car & Bike",
        color: const Color(0xFFFFEDD5),
      ), // bg-orange-100
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Get Loan, Invest Money",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827), // text-gray-900
            ),
          ),
          const SizedBox(height: 16),

          // First Row (4 items)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return _ServiceIconBox(service: services[index]);
            },
          ),

          const SizedBox(height: 20),

          // Second Row (3 items)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return _ServiceIconBox(service: services[index + 4]);
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceItem {
  final IconData icon;
  final String label;
  final Color color;

  _ServiceItem({required this.icon, required this.label, required this.color});
}

class _ServiceIconBox extends StatelessWidget {
  final _ServiceItem service;

  const _ServiceIconBox({required this.service});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: service.color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(service.icon, size: 24, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        Text(
          service.label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151), // text-gray-700
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
