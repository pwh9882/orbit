import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/models/broswer.dart';
import 'package:orbit/models/space.dart';
import 'package:orbit/models/webview_tab_viewer_contorller.dart';

class WebviewTabViewer extends StatelessWidget {
  const WebviewTabViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final webivewTabViewerController = Get.find<WebviewTabViewerController>();
    final broswer = Get.find<Broswer>();

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
// PopScope(
//         canPop: true,
//         child: 
//         onPopInvoked: (didPop) async {
//           // ScaffoldMessenger.of(context).showSnackBar(
//           //   SnackBar(
//           //     content:
//           //         Text('Pop invoked ${didPop ? 'successfully' : 'failed'}'),
//           //   ),
//           // );
//           if (didPop) {
//             var currentTab = webivewTabViewerController
//                 .webViewTabs[webivewTabViewerController.currentTabIndex.value];
//             if (await currentTab.canGoBack()) {
//               currentTab.goBack();
//             } else {
//               broswer.closeTab(
//                   (broswer.spaces[broswer.currentSpaceIndex.value] as Space)
//                       .currentSelectedTab!);
//               // webivewTabViewerController.closeWebViewTab(currentTab);
//               // broswer.spaces[broswer.currentSpaceIndex.value]
//               //     .currentSelectedTab = null;
//             }
//           }
//         },
//       ),