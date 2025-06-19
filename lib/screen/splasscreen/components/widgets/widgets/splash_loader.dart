import 'package:flutter/material.dart';

class SplashLoader extends StatelessWidget {
  final Animation<double> animation;

  const SplashLoader({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        return Opacity(
          opacity: animation.value,
          child: const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
            ),
          ),
        );
      },
    );
  }
}
