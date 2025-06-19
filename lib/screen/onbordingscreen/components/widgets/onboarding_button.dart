import 'package:flutter/material.dart';
import 'package:medhavi/utils/colors.dart';

class OnboardingButton extends StatelessWidget {
  final bool isLast;
  final int currentIndex;
  final VoidCallback onNext;
  final VoidCallback onDone;

  const OnboardingButton({
    super.key,
    required this.isLast,
    required this.currentIndex,
    required this.onNext,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: ElevatedButton(
        onPressed: isLast ? onDone : onNext,
        style: ElevatedButton.styleFrom(
          backgroundColor: currentIndex % 2 == 0 ? secondaryColor : primaryColor,
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          isLast ? "Get Started" : "Next",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
