import 'package:flutter/material.dart';

class CardChip extends StatelessWidget {
  const CardChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 38,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF176), Color(0xFFFFD740)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Color.fromARGB(255, 227, 186, 21), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: GridView.count(
          crossAxisCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            6,
            (i) => Container(
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.amber.shade900.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
