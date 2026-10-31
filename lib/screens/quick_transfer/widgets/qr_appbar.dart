import 'package:flutter/material.dart';

class QRAppBar extends StatelessWidget {
  const QRAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/red_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: height * 0.02,
              left: width * 0.04,
              right: width * 0.04,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Optional: Title or icons if needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}
