import 'package:flutter/material.dart';
import 'package:medhavi/screen/home_screen.dart';
import 'package:medhavi/screen/main_activity.dart';
import 'package:medhavi/screen/signup_screen.dart';
import 'package:medhavi/service/auth_service.dart';
import 'package:medhavi/utils/colors.dart';
import 'package:medhavi/utils/validators.dart';
import 'package:medhavi/widgets/custom_button.dart';
import 'package:medhavi/widgets/custom_textfield.dart';
import 'package:hive/hive.dart';

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
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final res = await ApiService().loginWithApi(
        _emailController.text,
        _passwordController.text,
      );

      if (res != null) {
        // ✅ **Save login state and navigate**
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
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
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
                  "Login ",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: SizedBox(
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
                                label: "Email",
                                icon: Icons.email,
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: Validator().validateEmail,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                label: "Password",
                                icon: Icons.lock,
                                controller: _passwordController,
                                keyboardType: TextInputType.text,
                                isHidden: true,
                                validator: Validator().validatePassword,
                              ),
                              const SizedBox(height: 20),
                              CustomButton(
                                text: 'Log in',
                                onPressed: _handleLogin,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account? "),
                                  InkWell(
                                    onTap: () {
                                      
                                      Navigator.pushReplacementNamed(context, 'signup');
                                    },
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
                            ],
                          ),
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
