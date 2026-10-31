import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    const user = {
      'name': "Rajesh Kumar",
      'phone': "+91 98765 43210",
      'email': "rajesh.kumar@email.com",
      'profilePicture': null,
      'kycStatus': "verified",
      'upiId': "rajesh@neopay",
      'walletBalance': "₹2,347.50",
    };

    const gradientColors = [
      Color(0xFF1E3A8A), // blue-800
      Color(0xFF4338CA), // indigo-700
      Color(0xFF6D28D9), // purple-700
    ];

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // slate-50
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/red_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),

            child: Stack(
              children: [
                // Background pattern (circles)
                Positioned(top: 32, right: 32, child: _circle(128)),
                Positioned(bottom: 16, left: 16, child: _circle(96)),
                Positioned(
                  top: height * 0.4,
                  right: width * 0.25,
                  child: _circle(64),
                ),
                // Foreground content
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _iconButton(
                            Icons.arrow_back,
                            () => Navigator.pop(context),
                          ),
                          const Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _iconButton(Icons.notifications, () {}),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Profile Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white24,
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              Positioned(
                                bottom: -2,
                                right: -2,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 12,
                                    color: Colors.blue.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user['name']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user['phone']!,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  user['email']!,
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // UPI ID & Wallet
                      Row(
                        children: [
                          _infoCard("UPI ID", user['upiId']!, width),
                          const SizedBox(width: 16),
                          _infoCard(
                            "Wallet Balance",
                            user['walletBalance']!,
                            width,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Account Management Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Account Management",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _accountTile(
                    Icons.qr_code,
                    "My QR Code",
                    "Share your QR to receive payments",
                  ),
                  _accountTile(
                    Icons.verified_user,
                    "KYC Verification",
                    "Verified Account",
                    badge: "Verified",
                    badgeColor: Colors.green,
                  ),
                  _accountTile(
                    Icons.account_balance,
                    "Linked Bank Accounts",
                    "Manage your bank accounts",
                    badge: "3",
                    badgeColor: Colors.blue,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Quick Actions",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _quickAction(
                        Icons.card_giftcard,
                        "Rewards & Cashback",
                        "View your rewards and offers",
                        Colors.purple,
                      ),
                      _quickAction(
                        Icons.credit_card,
                        "Saved Cards & Wallet",
                        "Manage cards and wallet balance",
                        Colors.blue,
                      ),
                      _quickAction(
                        Icons.history,
                        "Transaction History",
                        "View all your transactions",
                        Colors.green,
                      ),
                      _quickAction(
                        Icons.group,
                        "Refer & Earn",
                        "Invite friends and earn rewards",
                        Colors.orange,
                      ),
                      _quickAction(
                        Icons.settings,
                        "Settings",
                        "App preferences and security",
                        Colors.grey,
                      ),
                      _quickAction(
                        Icons.help_outline,
                        "Help & Support",
                        "Get help and contact support",
                        Colors.cyan,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.red.shade100),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.redAccent, Colors.red],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Sign out from your account",
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _infoCard(String title, String value, double width) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _accountTile(
    IconData icon,
    String title,
    String desc, {
    String? badge,
    Color? badgeColor,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.indigo],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        title: Row(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(width: 8),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor?.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontSize: 10,
                    color: badgeColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Text(desc, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  Widget _quickAction(IconData icon, String title, String desc, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.8), color],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            Text(
              desc,
              style: const TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
    );
  }
}
