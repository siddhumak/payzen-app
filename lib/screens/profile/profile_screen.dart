import 'package:flutter/material.dart';
import 'package:m2online_recharge_app/screens/profile/widgets/bottom_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    const String fullName = "John Doe";
    const String email = "john.doe@example.com";
    const String initials = "JD";

    return Scaffold(
      body: Stack(
        children: [
          // Background image instead of gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/red_background.jpg',
                ), // <-- your image path
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground content
          Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.045,
                  vertical: height * 0.060,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.055,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: width * 0.09,
                      height: width * 0.09,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        padding: EdgeInsets.zero,
                        iconSize: width * 0.055,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

              // Avatar, Name, Email
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.04),
                      CircleAvatar(
                        radius: width * 0.12,
                        backgroundColor: Colors.white,
                        child: Text(
                          initials,
                          style: TextStyle(
                            fontSize: width * 0.085,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        fullName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        email,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                    ],
                  ),
                ),
              ),

              // Bottom section
              const BottomSection(),
            ],
          ),
        ],
      ),
    );
  }
}
