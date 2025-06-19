import 'package:flutter/material.dart';

class SplashParticle extends StatelessWidget {
  final int index;
  final Animation<double> animation;

  const SplashParticle({
    super.key,
    required this.index,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final random = (index * 0.1) % 1.0;
    final progress = (animation.value + random) % 1.0;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      left: screenWidth * random,
      top: screenHeight * progress,
      child: Opacity(
        opacity: (0.3 + random * 0.7) * animation.value,
        child: Container(
          width: 2 + random * 4,
          height: 2 + random * 4,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
