import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:orbit/models/broswer.dart';
import 'package:orbit/views/sidebar_view/menus/menu_space_page_indicator/menu_space_page_indicator.dart';
import 'package:orbit/views/sidebar_view/menus/space_tree_view.dart';

class MenuSpacePageView extends StatelessWidget {
  MenuSpacePageView({super.key});
  final broswer = Get.find<Broswer>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final pageviewController = PageController(
        initialPage: broswer.currentSpaceIndex.value,
      );
      broswer.pageviewController = pageviewController;
      return Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              controller: pageviewController,
              onPageChanged: (int index) {
                broswer.currentSpaceIndex.value = index;
              },
              children: broswer.spaces
                  .asMap()
                  .entries
                  .map((entry) => SpaceTreeView(spaceIndex: entry.key))
                  .toList(),
            ),
          ),
          MenuSpacePageIndicator(pageviewController: pageviewController),
        ],
      );
    });
  }
}
