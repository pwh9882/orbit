import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/models/broswer.dart';
import 'package:orbit/views/sidebar_view/menus/menu_space_page_indicator.dart';
import 'package:orbit/views/sidebar_view/menus/space_items_list_view.dart';

class MenuSpacePageView extends StatelessWidget {
  MenuSpacePageView({super.key});
  final broswer = Get.find<Broswer>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final pageviewController =
          PageController(initialPage: broswer.currentSpaceIndex.value);
      return Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            controller: pageviewController,
            onPageChanged: (int index) {
              broswer.currentSpaceIndex.value = index;
            },
            children: broswer.spaces
                .map((space) => SpaceItemsListView(space: space))
                .toList(),
          ),
          MenuSpacePageIndicator(pageviewController: pageviewController),
        ],
      );
    });
  }
}
