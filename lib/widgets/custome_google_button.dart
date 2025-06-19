import 'package:flutter/material.dart';

class GoogleIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GoogleIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Image.asset(
          'assets/images/google.png',
          height: 40,
          width: 30,
        ),
      ),
    );
  }
}
