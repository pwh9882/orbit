import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MenuSpacePageIndicator extends StatelessWidget {
  final int currentPage = 0;
  final int totalPages = 3;

  const MenuSpacePageIndicator({
    super.key,
    required this.controller,
    required this.count,
  });
  final PageController controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            // history
            onPressed: () {
              // TODO: implement onPressed
            },
            icon: Icon(
              Icons.history_outlined,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
          SmoothPageIndicator(
            controller: controller,
            count: count,
            effect: ScrollingDotsEffect(
              activeDotColor:
                  Theme.of(context).colorScheme.onSecondaryContainer,
              dotColor: Theme.of(context)
                  .colorScheme
                  .onSecondaryContainer
                  .withOpacity(0.5),
              dotHeight: 15.0,
              dotWidth: 15.0,
              spacing: 12.0,
            ),
            onDotClicked: (index) => controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            ),
          ),
          IconButton(
            // history
            onPressed: () {
              // TODO: implement onPressed
            },
            icon: Icon(
              Icons.add_circle_outline,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
