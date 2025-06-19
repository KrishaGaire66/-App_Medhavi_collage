import 'package:flutter/material.dart';

class SplashText extends StatelessWidget {
  final AnimationController animation;
  final Animation<double> slide;
  final Animation<double> fade;

  const SplashText({
    super.key,
    required this.animation,
    required this.slide,
    required this.fade,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        return Transform.translate(
          offset: Offset(0, slide.value),
          child: Opacity(
            opacity: fade.value,
            child: Column(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.white, Colors.cyan.shade200],
                  ).createShader(bounds),
                  child: const Text(
                    "Medhavi College",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      shadows: [Shadow(blurRadius: 10, color: Colors.black26, offset: Offset(0, 2))],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Excellence in Education",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
