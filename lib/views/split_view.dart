import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orbit/models/broswer.dart';
import 'package:orbit/views/sidebar_view/custom_sidebar_drawer.dart';

class SplitView extends StatelessWidget {
  const SplitView({
    super.key,
    // menu and content are now configurable
    required this.menu,
    required this.content,
    // these values are now configurable with sensible default values
    this.breakpoint = 600,
    this.menuWidth = 300,
  });
  final Widget menu;
  final Widget content;
  final double breakpoint;
  final double menuWidth;

  Future<bool?> showBackDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Are you sure you want to leave this page?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Nevermind'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Widget widget;
    if (screenWidth >= breakpoint) {
      // widescreen: menu on the left, content on the right
      widget = Row(
        children: [
          SizedBox(
            width: menuWidth,
            child: menu,
          ),
          Container(width: 0.5, color: Colors.black),
          Expanded(
              child: Scaffold(
            body: content,
            // endDrawer: const CustomContentDrawer(),
            // drawerEdgeDragWidth: screenWidth * 0.5,
          )),
        ],
      );
    } else {
      // narrow screen: show content, menu inside drawer
      widget = Scaffold(
        body: content,
        drawer: SizedBox(
          width: menuWidth,
          child: CustomSidebarDrawer(
            child: menu,
          ),
        ),
        // endDrawer: const CustomContentDrawer(),
        drawerEdgeDragWidth: screenWidth * 0.5,
      );
    }

    var broswer = Get.find<Broswer>();

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }

        if (await broswer.goBackWebviewTab()) {
          return;
        }

        final bool shouldPop = await showBackDialog(context) ?? false;
        if (context.mounted && shouldPop) {
          SystemNavigator.pop();
        }
      },
      child: widget,
    );
  }
}
