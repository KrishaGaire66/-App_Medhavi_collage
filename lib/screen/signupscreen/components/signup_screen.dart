import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medhavi/routes/routes.dart';
import 'package:medhavi/screen/signupscreen/components/widgets/signup_card.dart';
import 'package:medhavi/service/auth_service.dart';
import 'package:medhavi/utils/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authBox = Hive.box('authBox');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final success = await ApiService().signUpWithApi(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _phoneNumberController.text,
        "hp",
      );

      Navigator.pop(context); // close loading indicator

      if (success) {
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

        Navigator.pushReplacementNamed(context, Routes.main);
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
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image(
                  image: const AssetImage('assets/images/logo.png'),
                  height: 100,
                  width: 100,
                ),
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: SignupCard(
                    nameController: _nameController,
                    emailController: _emailController,
                    phoneController: _phoneNumberController,
                    passwordController: _passwordController,
                    onSignupPressed: _handleSignup,
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
