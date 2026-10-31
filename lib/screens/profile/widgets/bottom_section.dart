import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m2online_recharge_app/screens/profile/widgets/profile_listtile.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(width * 0.08)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.03,
          horizontal: width * 0.04,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            profileOptionTile(
              backgroundColor: Colors.lightBlue.shade50,
              icon: Icons.person_outline,
              iconColor: Colors.blue,
              title: 'My Profile',
              onTap: () {
                Get.offNamed('/profiledetails');
              },
            ),
            SizedBox(height: height * 0.015),
            profileOptionTile(
              backgroundColor: Colors.lightGreen.shade50,
              icon: Icons.language_outlined,
              iconColor: Colors.green,
              title: 'Change Language',
              onTap: () {},
            ),
            SizedBox(height: height * 0.015),
            profileOptionTile(
              backgroundColor: Colors.purple.shade50,
              icon: Icons.settings_outlined,
              iconColor: Colors.purple,
              title: 'Settings',
              onTap: () {},
            ),
            SizedBox(height: height * 0.015),
            profileOptionTile(
              backgroundColor: Colors.orange.shade50,
              icon: Icons.help_outline_rounded,
              iconColor: Colors.deepOrange,
              title: 'Help & Support',
              onTap: () {},
            ),
            SizedBox(height: height * 0.015),
            profileOptionTile(
              backgroundColor: Colors.red.shade50,
              icon: Icons.logout,
              iconColor: Colors.red,
              title: 'Logout',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
