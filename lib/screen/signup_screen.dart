import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medhavi/routes/routes.dart';
import 'package:medhavi/screen/login_screen.dart';
import 'package:medhavi/screen/main_activity.dart';
import 'package:medhavi/service/auth_service.dart';
import 'package:medhavi/utils/colors.dart';
import 'package:medhavi/utils/validators.dart';
import 'package:medhavi/widgets/custom_button.dart';
import 'package:medhavi/widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _authBox = Hive.box('authBox');

  @override

  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      final isSignupSuccessful = await ApiService().signUpWithApi(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _phoneNumberController.text,
        "hp",
      );

      // Close loading indicator
      Navigator.pop(context);

      if (isSignupSuccessful) {
        // ✅ Save user data to Hive
        _authBox.put('isLoggedIn', true);
        _authBox.put('username', _nameController.text);
        _authBox.put('email', _emailController.text);
        _authBox.put('phone', _phoneNumberController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign Up Successful! Redirecting to Home...'),

            backgroundColor: Colors.green,
          ),
        );

        // 🚀 Navigate to MainActivity
        
        Navigator.pushReplacementNamed(
                              context,
                              Routes.main,
                            );
                          
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign Up Failed! Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(gradient: linearGradient),
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Sign Up ",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomTextField(
                              label: "Full Name",
                              icon: Icons.person,
                              controller: _nameController,
                              validator: Validator().validateName,
                            ),
                            const SizedBox(height: 15),
                            CustomTextField(
                              label: "Email",
                              icon: Icons.email,
                              controller: _emailController,
                              validator: Validator().validateEmail,
                            ),
                            const SizedBox(height: 15),
                            CustomTextField(
                              label: "Phone Number",
                              icon: Icons.phone,
                              controller: _phoneNumberController,
                              validator: Validator().validatePhone,
                            ),
                            const SizedBox(height: 15),
                            CustomTextField(
                              label: "Password",
                              icon: Icons.lock,
                              controller: _passwordController,
                              isHidden: true,
                              validator: Validator().validatePassword,
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              text: 'Create Account',
                              onPressed: _handleSignup,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account? "),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
