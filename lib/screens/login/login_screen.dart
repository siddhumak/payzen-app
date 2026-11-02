import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payzen_app/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Email')),
            const TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.offNamed(AppRoutes.dashboard),
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.loginselect),
              child: const Text('Create account'),
            ),
          ],
        ),
      ),
    );
  }
}
