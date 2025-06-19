import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:medhavi/screen/loginscreen/components/widgets/login_card.dart';
import 'package:medhavi/screen/main_activity.dart';
import 'package:medhavi/service/auth_service.dart';
import 'package:medhavi/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authBox = Hive.box('authBox');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final res = await ApiService().loginWithApi(
        _emailController.text,
        _passwordController.text,
      );

      if (res != null) {
        _authBox.put('isLoggedIn', true);
        _authBox.put('email', _emailController.text);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainActivity()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Invalid credentials!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/logo.png',
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.3,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 1),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: LoginCard(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    onLoginPressed: _handleLogin,
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
