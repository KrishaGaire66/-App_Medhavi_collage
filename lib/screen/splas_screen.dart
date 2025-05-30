import 'package:flutter/material.dart';
import 'package:medhavi/screen/home_screen.dart';
import 'package:medhavi/screen/login_screen.dart';
import 'package:medhavi/screen/main_activity.dart';
import 'package:medhavi/screen/onbording_screen.dart';
import 'package:medhavi/utils/colors.dart';
import 'package:hive/hive.dart';

class SplasScreen extends StatefulWidget {
  const SplasScreen({super.key});

  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(Duration(seconds: 6));

    final authBox = Hive.box('authBox');
    final isOnboarded = authBox.get('isOnboarded', defaultValue: false);
    final token = authBox.get('token');

    Widget nextScreen;

    if (!isOnboarded) {
      nextScreen = OnboardingScreen(); // Navigate to onboarding if not done
    } else if (token != null) {
      nextScreen = MainActivity(); // If token exists, go to Home
    } else {
      nextScreen = LoginScreen(); // Otherwise, go to Login
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextScreen),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: linearGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage(
                  "https://images.pexels.com/photos/1462630/pexels-photo-1462630.jpeg",
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Medhavi College",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
