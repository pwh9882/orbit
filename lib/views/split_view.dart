import 'package:flutter/material.dart';
import 'package:orbit/views/custom_content_drawer.dart';
import 'package:orbit/views/sidebar/custom_sidebar_drawer.dart';

class SplitView extends StatelessWidget {
  const SplitView({
    super.key,
    // menu and content are now configurable
    required this.menu,
    required this.content,
    // these values are now configurable with sensible default values
    this.breakpoint = 600,
    this.menuWidth = 240,
  });
  final Widget menu;
  final Widget content;
  final double breakpoint;
  final double menuWidth;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= breakpoint) {
      // widescreen: menu on the left, content on the right
      return Row(
        children: [
          SizedBox(
            width: menuWidth,
            child: menu,
          ),
          Container(width: 0.5, color: Colors.black),
          Expanded(
              child: Scaffold(
            body: content,
            endDrawer: const CustomContentDrawer(),
            drawerEdgeDragWidth: screenWidth * 0.5,
          )),
        ],
      );
    } else {
      // narrow screen: show content, menu inside drawer
      return Scaffold(
        body: content,
        drawer: SizedBox(
          width: menuWidth,
          child: CustomSidebarDrawer(
            child: menu,
          ),
        ),
        endDrawer: const CustomContentDrawer(),
        drawerEdgeDragWidth: screenWidth * 0.5,
      );
    }
  }
}
