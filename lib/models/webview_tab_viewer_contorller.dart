import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:orbit/views/content_view/webivew_tab.dart';

const kHomeUrl = 'https://google.com';

class WebviewTabViewerController extends GetxController {
  var webViewTabs = <WebViewTab>[];
  final currentTabIndex = (-1).obs;

  var currentTabUrl = ''.obs;
  var currentTabUrlHost = ''.obs;

  WebViewTab _createWebViewTab(
      {required String tabId, String? url, int? windowId}) {
    WebViewTab? webViewTab;

    if (url == null && windowId == null) {
      url = kHomeUrl;
    }

    webViewTab = WebViewTab(
      tabId: tabId,
      url: url,
      windowId: windowId,
      onCloseTabRequested: () {
        if (webViewTab != null) {
          _closeWebViewTab(webViewTab);
        }
      },
      onCreateTabRequested: (createWindowAction) {
        // _addWebViewTab(windowId: createWindowAction.windowId);
      },
      key: GlobalKey(),
      onStateUpdated: () {},
    );

    return webViewTab;
  }

  void addWebViewTab({required String tabId, String? url, int? windowId}) {
    var newTab = _createWebViewTab(tabId: tabId, url: url, windowId: windowId);
    webViewTabs.add(newTab);

    // setState(() {
    //   currentTabIndex = webViewTabs.length - 1;
    // });
    // currentTabIndex.value = webViewTabs.length - 1;
    _selectWebViewTab(newTab);
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
      await webViewTabs[currentTabIndex.value].pause();
    }
    final webViewIndex = webViewTabs.indexOf(webViewTab);
    currentTabIndex.value = webViewIndex;
    await webViewTabs[webViewIndex].resume();
    Fluttertoast.showToast(
      msg: 'Selected WebView Index: $webViewIndex',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
    currentTabUrl.value = webViewTabs[webViewIndex].currentUrl ?? '';
    currentTabUrlHost.value = Uri.parse(currentTabUrl.value).host;
  }

  void closeWebViewTabByTabId(String tabId) {
    final webViewTab = webViewTabs.firstWhere(
      (tab) => tab.tabId == tabId,
    );
    _closeWebViewTab(webViewTab);
  }

  void _closeWebViewTab(WebViewTab webViewTab) {
    webViewTabs.remove(webViewTab);
    currentTabIndex.value = -1;
  }

  void _closeAllWebViewTabs() {
    webViewTabs.clear();
    // webViewTabs.add(createWebViewTab());
    //   setState(() {
    //     currentTabIndex = 0;
    //   });
    currentTabIndex.value = 0;
  }
}
