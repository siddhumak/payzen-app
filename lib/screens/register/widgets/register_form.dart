import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/components/custom_textfield.dart';
import 'package:payzen_app/constant/colors.dart';
import 'package:payzen_app/screens/register/widgets/login_redirect_text.dart';
import 'package:payzen_app/utils/custom_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void register() {
    // TODO: Add register logic here
  }

  Widget buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey[800],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Register',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Create a new account to start using the app',
                  style: GoogleFonts.lexend(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 25),

              buildLabel("First Name"),
              const SizedBox(height: 5),
              CustomTextField(
                controller: nameController,
                hint: 'Enter your first name',
                prefixIcon: const Icon(Icons.person_outline),
                label: 'First Name',
              ),
              const SizedBox(height: 16),

              buildLabel("Last Name"),
              const SizedBox(height: 5),
              CustomTextField(
                controller: nameController,
                hint: 'Enter last name',
                prefixIcon: const Icon(Icons.person_outline),
                label: 'Last Name',
              ),
              const SizedBox(height: 16),

              buildLabel("Email"),
              const SizedBox(height: 5),
              CustomTextField(
                controller: emailController,
                hint: 'Enter your email address',
                prefixIcon: const Icon(Icons.email_outlined),
                label: 'Email',
              ),
              const SizedBox(height: 16),

              buildLabel("Mobile Number"),
              const SizedBox(height: 5),
              CustomTextField(
                controller: mobileController,
                hint: 'Enter your mobile number',
                prefixIcon: const Icon(Icons.phone_android),
                keyboardType: TextInputType.phone,
                label: 'Mobile Number',
              ),
              const SizedBox(height: 16),

              buildLabel("Password"),
              const SizedBox(height: 5),
              CustomTextField(
                controller: passwordController,
                hint: 'Create a password',
                obscureText: obscurePassword,
                prefixIcon: const Icon(LucideIcons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? LucideIcons.eyeOff : LucideIcons.eye,
                    size: 20,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
                label: '',
              ),
              const SizedBox(height: 16),

              buildLabel("Confirm Password"),
              const SizedBox(height: 5),
              CustomTextField(
                controller: confirmPasswordController,
                hint: 'Re-enter password',
                obscureText: obscureConfirmPassword,
                prefixIcon: const Icon(LucideIcons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureConfirmPassword
                        ? LucideIcons.eyeOff
                        : LucideIcons.eye,
                    size: 20,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                ),
                label: '',
              ),
              const SizedBox(height: 24),

              CustomButton(
                label: 'Register',
                onPressed: register,
                icon: LucideIcons.userPlus,
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              const SizedBox(height: 16),

              const LoginRedirectText(),
            ],
          ),
        ),
      ),
    );
  }
}
