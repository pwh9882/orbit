import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/views/content_view/webivew_tab.dart';

const kHomeUrl = 'https://google.com';

class WebviewTabViewerController extends GetxController {
  var webViewTabs = <WebViewTab>[];
  final currentTabIndex = (-1).obs;

  WebViewTab _createWebViewTab(
      {required String tabId, String? url, int? windowId}) {
    WebViewTab? webViewTab;

    if (url == null && windowId == null) {
      url = kHomeUrl;
    }

    webViewTab = WebViewTab(
      tabId: tabId,
      url: url,
      controller: WebViewTabController(),
      windowId: windowId,
      onCloseTabRequested: () {
        if (webViewTab != null) {
          _closeWebViewTab(webViewTab);
        }
      },
      onCreateTabRequested: (createWindowAction) {
        // _addWebViewTab(windowId: createWindowAction.windowId);
      },
    );

    return webViewTab;
  }

  void addWebViewTab({required String tabId, String? url, int? windowId}) {
    webViewTabs
        .add(_createWebViewTab(tabId: tabId, url: url, windowId: windowId));

    // setState(() {
    //   currentTabIndex = webViewTabs.length - 1;
    // });
    currentTabIndex.value = webViewTabs.length - 1;
  }

  void selectWebViewTabByTabId(String tabId) {
    final webViewTab = webViewTabs.firstWhere((tab) => tab.tabId == tabId);
    debugPrint('input tabId: $tabId');
    debugPrint('selectWebViewTabByTabId: ${webViewTab.tabId}');

    _selectWebViewTab(webViewTab);
  }

  void _selectWebViewTab(WebViewTab webViewTab) async {
    // if (currentTabIndex.value == webViewIndex) {
    //   webViewTab.controller.resume();
    //   return;
    // }
    if (currentTabIndex.value != -1) {
      debugPrint('pause ${currentTabIndex.value}th tab');
      await webViewTabs[currentTabIndex.value].controller.pause();
    }
    final webViewIndex = webViewTabs.indexOf(webViewTab);
    currentTabIndex.value = webViewIndex;
    await webViewTabs[0].controller.resume();
    debugPrint('resume ${webViewIndex}th tab');
    // webViewTab.controller.resume();
    // setState(() {
    //   currentTabIndex = webViewIndex;
    //   showWebViewTabsViewer = false;
    // });
  }

  void closeWebViewTabByTabId(String tabId) {
    final webViewTab = webViewTabs.firstWhere(
      (tab) => tab.tabId == tabId,
    );
    _closeWebViewTab(webViewTab);
  }

  void _closeWebViewTab(WebViewTab webViewTab) {
    // final webViewIndex = webViewTabs.indexOf(webViewTab);
    webViewTabs.remove(webViewTab);
    currentTabIndex.value = -1;
    // if (currentTabIndex > webViewIndex) {
    //   currentTabIndex.value--;
    // }
    // // if (webViewTabs.isEmpty) {
    // //   webViewTabs.add(createWebViewTab());
    // //   currentTabIndex = 0;
    // // }
    // // setState(() {
    // //   currentTabIndex = max(0, min(webViewTabs.length - 1, currentTabIndex));
    // // });
    // currentTabIndex.value =
    //     currentTabIndex.value.clamp(0, webViewTabs.length - 1);
  }

  void _closeAllWebViewTabs() {
    webViewTabs.clear();
    // webViewTabs.add(createWebViewTab());
    //   setState(() {
    //     currentTabIndex = 0;
    //   });
    currentTabIndex.value = 0;
  }

  void debugPrintWebViewTabs() {
    debugPrint('\n webviews info\n\n');
    debugPrint(currentTabIndex.value.toString());
    debugPrint(webViewTabs.length.toString());
    // tabs
    for (var i = 0; i < webViewTabs.length; i++) {
      debugPrint('tab $i: ${webViewTabs[i].tabId}');
    }
    debugPrint('\n webviews info\n\n');
  }
}
