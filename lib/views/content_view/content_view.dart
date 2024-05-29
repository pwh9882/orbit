import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/models/broswer.dart';
import 'package:orbit/models/space.dart';
import 'package:orbit/views/content_view/webview_tab_viewer.dart';
import 'package:orbit/views/sidebar_view/empty_page.dart';

class ContentView extends StatelessWidget {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context) {
    // return const EmptyPage();
    return Obx(() {
      final broswer = Get.find<Broswer>();
      if (broswer.spaces.isEmpty ||
          (broswer.spaces[broswer.currentSpaceIndex.value] as Space)
                  .currentSelectedTab ==
              null) {
        return const EmptyPage();
      }
      return const WebviewTabViewer();
    });
  }
}
