import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  final AnimationController animation;
  final Animation<double> scale;
  final Animation<double> opacity;

  const SplashLogo({
    super.key,
    required this.animation,
    required this.scale,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        return Transform.scale(
          scale: scale.value,
          child: Opacity(
            opacity: opacity.value,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.white30, blurRadius: 30, spreadRadius: 5)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
