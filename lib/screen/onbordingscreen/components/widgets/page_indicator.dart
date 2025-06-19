import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int count;

  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: 10,
          width: currentIndex == index ? 24 : 10,
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.white : Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }
}
