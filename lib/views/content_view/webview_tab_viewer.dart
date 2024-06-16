import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/models/webview_tab_viewer_contorller.dart';

class WebviewTabViewer extends StatelessWidget {
  const WebviewTabViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final webivewTabViewerController = Get.find<WebviewTabViewerController>();

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: webivewTabViewerController.currentTabIndex.value,
          children: webivewTabViewerController.webViewTabs
              .map((webViewTab) => webViewTab)
              .toList(),
        ),
      ),
    );
  }
}
