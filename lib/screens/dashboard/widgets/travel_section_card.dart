import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TravelSectionCard extends StatelessWidget {
  const TravelSectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_ServiceItem> services = [
      _ServiceItem(
        icon: LucideIcons.plane,
        label: "Flight Tickets",
        color: Colors.blue.shade100,
      ),
      _ServiceItem(
        icon: LucideIcons.bus,
        label: "Bus Tickets",
        color: Colors.yellow.shade100,
      ),
      _ServiceItem(
        icon: LucideIcons.train,
        label: "Train Tickets",
        color: Colors.blue.shade100,
      ),
      _ServiceItem(
        icon: LucideIcons.building,
        label: "Hotel Booking",
        color: Colors.orange.shade100,
      ),
      _ServiceItem(
        icon: LucideIcons.gift,
        label: "Cashback & Offers",
        color: Colors.blue.shade100,
      ),
      _ServiceItem(
        icon: LucideIcons.creditCard,
        label: "Gift Cards",
        color: Colors.green.shade100,
      ),
      _ServiceItem(
        icon: LucideIcons.film,
        label: "Movie Tickets",
        color: Colors.red.shade100,
      ),
      _ServiceItem(
        icon: LucideIcons.moreHorizontal,
        label: "See All Services",
        color: Colors.grey.shade200,
      ),
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Travel & More",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final service = services[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: service.color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      service.icon,
                      size: 24,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service.label,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
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
