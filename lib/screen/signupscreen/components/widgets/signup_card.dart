import 'package:flutter/material.dart';
import 'package:medhavi/screen/loginscreen/components/login_screen.dart';
import 'package:medhavi/utils/colors.dart';
import 'package:medhavi/utils/validators.dart';
import 'package:medhavi/widgets/custom_button.dart';
import 'package:medhavi/widgets/custom_textfield.dart';
import 'package:medhavi/widgets/custome_google_button.dart';

class SignupCard extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final VoidCallback? onSignupPressed;

  const SignupCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.onSignupPressed,
  });

  @override
  State<SignupCard> createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  bool _isChecked = false;
  bool _isPasswordVisible = false;
  bool isSignupButtonDisabled = false;

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(1),
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomTextField(
                label: "Full Name",
                icon: Icons.person,
                controller: widget.nameController,
                validator: Validator().validateName,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: "Email",
                icon: Icons.email,
                controller: widget.emailController,
                validator: Validator().validateEmail,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: "Phone Number",
                icon: Icons.phone,
                controller: widget.phoneController,
                validator: Validator().validatePhone,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: "Password",
                icon: Icons.lock,
                controller: widget.passwordController,
                isHidden: true,
                validator: Validator().validatePassword,
              ),
              const SizedBox(height: 10),

              // Accept Terms and Conditions
              LabeledCheckbox(
                label: 'I accept the terms and conditions',
                value: _isChecked,
                onChanged: _onCheckboxChanged,
              ),

              const SizedBox(height: 10),

              // Create Account Button (disabled if not accepted)
              CustomButton(
                text: 'Create Account',
                onPressed: widget.onSignupPressed ?? () {},
              ),

              SizedBox(height: 15),
              // Log In Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Log In',
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
            child: Text(label, style: labelStyle ?? TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }
}
