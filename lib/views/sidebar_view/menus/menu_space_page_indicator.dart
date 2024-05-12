import 'package:flutter/material.dart';

class MenuSpacePageIndicator extends StatelessWidget {
  final int currentPage = 0;
  final int totalPages = 3;

  const MenuSpacePageIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          totalPages,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPage == index ? Colors.white : Colors.white30,
            ),
          ),
        ),
      ),
    );
  }
}
