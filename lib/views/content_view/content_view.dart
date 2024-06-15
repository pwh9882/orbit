import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/models/broswer.dart';
import 'package:orbit/views/content_view/webview_tab_viewer.dart';
import 'package:orbit/views/sidebar_view/empty_page.dart';

class ContentView extends StatelessWidget {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context) {
    // return const EmptyPage();
    final broswer = Get.find<Broswer>();
    return Obx(
      () => IndexedStack(
        index: broswer.webviewTabViewerController.currentTabIndex.value == -1
            ? 0
            : 1,
        children: const [
          EmptyPage(),
          WebviewTabViewer(),
        ],
      ),
    );
    // return Obx(() {
    //   if (broswer.webviewTabViewerController.currentTabIndex.value == -1) {
    //     return const EmptyPage();
    //   }
    //   return const WebviewTabViewer();
    // });
  }
}
