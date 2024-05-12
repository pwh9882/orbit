import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomContentDrawerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  var offset = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void updateOffset(double newOffset) {
    offset.value = newOffset;
  }

  void handleDragStart(DragStartDetails details) {
    _animationController.stop();
  }

  void handleDragUpdate(DragUpdateDetails details, double screenWidth) {
    double newOffset =
        math.max(0.0, math.min(offset.value + details.delta.dx, screenWidth));
    updateOffset(newOffset);
  }

  void handleDragEnd(DragEndDetails details, BuildContext context) {
    if (offset.value > 10) {
      Navigator.pop(context);
    }
    _animation = Tween<double>(begin: offset.value, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        updateOffset(_animation.value);
      });
    _animationController.forward(from: 0.0);
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
}

class CustomContentDrawer extends StatelessWidget {
  const CustomContentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomContentDrawerController());
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onHorizontalDragStart: controller.handleDragStart,
      onHorizontalDragUpdate: (details) =>
          controller.handleDragUpdate(details, screenWidth),
      onHorizontalDragEnd: (details) =>
          controller.handleDragEnd(details, context),
      child: Obx(
        () => Transform.translate(
          offset: Offset(controller.offset.value, 0.0),
          child: Drawer(
            width: screenWidth,
            child: const Column(
              children: [
                Text('Item 1'),
                Text('Item 2'),
                Text('Item 3'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
