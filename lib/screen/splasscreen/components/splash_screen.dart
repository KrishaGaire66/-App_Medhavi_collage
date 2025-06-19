import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medhavi/screen/loginscreen/components/login_screen.dart';
import 'package:medhavi/screen/main_activity.dart';
import 'package:medhavi/screen/onbordingscreen/onboarding_screen.dart';
import 'package:medhavi/screen/splasscreen/components/widgets/widgets/splash_loader.dart';
import 'package:medhavi/screen/splasscreen/components/widgets/widgets/splash_logo.dart';
import 'package:medhavi/screen/splasscreen/components/widgets/widgets/splash_particle.dart';
import 'package:medhavi/screen/splasscreen/components/widgets/widgets/splash_text.dart';
import 'package:medhavi/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _bgController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textFade;
  late Animation<double> _textSlide;
  late Animation<double> _bgAnim;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
    _navigateAfterDelay();
  }

  void _setupAnimations() {
    _logoController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _textController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _bgController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));

    _logoScale = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _logoController, curve: Curves.elasticOut));
    _logoOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeInOut));
    _textFade = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _textController, curve: Curves.easeInOut));
    _textSlide = Tween(begin: 50.0, end: 0.0).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic));
    _bgAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _bgController, curve: Curves.easeInOut));
  }

  void _startAnimations() async {
    _bgController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 600));
    _textController.forward();
  }

  void _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 4));
    final box = Hive.box('authBox');
    final isOnboarded = box.get('isOnboarded', defaultValue: false);
    final token = box.get('token');

    final next = !isOnboarded ? const OnboardingScreen() : token != null ? const MainActivity() : const LoginScreen();
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => next));
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgController,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(gradient: linearGradient1),
            child: Stack(
              children: [
                ...List.generate(20, (i) => SplashParticle(index: i, animation: _bgAnim)),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SplashLogo(animation: _logoController, scale: _logoScale, opacity: _logoOpacity),
                      const SizedBox(height: 40),
                      SplashText(animation: _textController, slide: _textSlide, fade: _textFade),
                      const SizedBox(height: 60),
                      SplashLoader(animation: _textFade),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
