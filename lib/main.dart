import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payzen_app/screens/main/controller/main_controller.dart';
import 'package:payzen_app/theme/theme.dart';
import 'routes/app_routes.dart';

void main() {
  Get.put(MainController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PayZen',
      debugShowCheckedModeBanner: false,
      theme: neoPayTheme, // Assuming neoPayTheme is defined in theme.dart
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.home,
    );
  }
}
