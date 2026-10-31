import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/qr_appbar.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/widgets/qr_code_card.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color(0xFFF5F8FF),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.5),
            child: const QRAppBar(),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: height * 0.1),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(width * 0.04),
              child: const Column(children: [SizedBox(height: 120)]),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 18,
          child: ClipOval(
            child: Material(
              color: Colors.white.withOpacity(0.85),
              child: InkWell(
                onTap: () {
                  Get.offNamed('/main');
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back, color: Colors.black, size: 24),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: height * 0.20,
          left: width * 0.04,
          right: width * 0.04,
          child: const QRCodeCard(
            upiId: "your-upi-id@paytm",
            title: "Your QR Code",
            subtitle: "Anyone can scan to send you money",
          ),
        ),
      ],
    );
  }
}
