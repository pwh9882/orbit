import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSidebarDrawerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  RxDouble offset = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  void updateOffset(double newOffset) {
    offset.value = newOffset;
  }

  void resetOffset() {
    offset.value = 0.0;
  }

  void handleDragStart(DragStartDetails details) {
    _animationController.stop();
  }

  void handleDragUpdate(DragUpdateDetails details) {
    double newOffset = math.min(0.0, offset.value + details.delta.dx);
    updateOffset(newOffset);
    // debugPrint('offset: $offset');
  }

  void handleDragEnd(DragEndDetails details, BuildContext context) {
    if (offset.value < -10) {
      Navigator.pop(context);
    }
    _animation = Tween<double>(begin: offset.value, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut))
      ..addListener(() {
        updateOffset(_animation.value);
      });
    _animationController.forward(from: 0);
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
}

class CustomSidebarDrawer extends StatelessWidget {
  const CustomSidebarDrawer({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomSidebarDrawerController());
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onHorizontalDragStart: controller.handleDragStart,
      onHorizontalDragUpdate: controller.handleDragUpdate,
      onHorizontalDragEnd: (details) =>
          controller.handleDragEnd(details, context),
      child: Obx(
        () => Transform.translate(
          offset: Offset(controller.offset.value, 0),
          child: Drawer(
            width: screenWidth,
            // backgroundColor: Colors.indigo,
            child: child,
          ),
        ),
      ),
    );
  }
}
