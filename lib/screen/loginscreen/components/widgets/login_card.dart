import 'package:flutter/material.dart';
import 'package:medhavi/utils/colors.dart';
import 'package:medhavi/utils/validators.dart';
import 'package:medhavi/widgets/custom_button.dart';
import 'package:medhavi/widgets/custom_textfield.dart';
import 'package:medhavi/widgets/custome_google_button.dart';

class LoginCard extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLoginPressed;

  const LoginCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLoginPressed,
  });

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  // ✅ State variables declared here!
  bool _isChecked = false;
  bool _isPasswordVisible = false; // optional if needed later

  void _onCheckboxChanged(bool? newValue) {
    setState(() {
      _isChecked = newValue ?? false;
    });
  }

  void _onGoogleLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.g_mobiledata, color: Colors.white), // Google-style "G"
            SizedBox(width: 10),
            Text('Signing in with Google...'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              CustomTextField(
                label: "Email",
                icon: Icons.email,
                controller: widget.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: Validator().validateEmail,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: "Password",
                icon: Icons.lock,
                controller: widget.passwordController,
                keyboardType: TextInputType.text,
                isHidden: true,
                validator: Validator().validatePassword,
              ),
              const SizedBox(height: 10),
              LabeledCheckbox(
                label: 'I accept the terms and conditions',
                value: _isChecked,
                onChanged: _onCheckboxChanged,
              ),
              const SizedBox(height: 20),
              CustomButton(text: 'Log in', onPressed: widget.onLoginPressed),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  InkWell(
                    onTap:
                        () => Navigator.pushReplacementNamed(context, 'signup'),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              GoogleIconButton(onPressed: () => _onGoogleLogin()),
            ],
          ),
        ),
      ),
    );
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.labelStyle,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (val) => onChanged(val ?? false),
          activeColor: primaryColor,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!value),
            child: Text(
              label,
              style: labelStyle ?? const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
