import 'package:flutter/material.dart';
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

  void _selectWebViewTab(WebViewTab webViewTab) async {
    if (currentTabIndex.value != -1) {
      await webViewTabs[currentTabIndex.value].pause();
    }
    final webViewIndex = webViewTabs.indexOf(webViewTab);
    currentTabIndex.value = webViewIndex;
    await webViewTabs[webViewIndex].resume();
    currentTabUrl.value = webViewTabs[webViewIndex].currentUrl ?? '';
    currentTabUrlHost.value = Uri.parse(currentTabUrl.value).host;
  }

  void _closeWebViewTab(WebViewTab webViewTab) {
    currentTabUrl.value = '';
    currentTabUrlHost.value = '';

    webViewTabs.remove(webViewTab);
    currentTabIndex.value = -1;
  }

  void addWebViewTab({required String tabId, String? url, int? windowId}) {
    var newTab = _createWebViewTab(tabId: tabId, url: url, windowId: windowId);
    webViewTabs.add(newTab);
    _selectWebViewTab(newTab);
  }

  void selectWebViewTabByTabId(String tabId) {
    final webViewTab = webViewTabs.firstWhere((tab) => tab.tabId == tabId);
    _selectWebViewTab(webViewTab);
  }

  void closeWebViewTabByTabId(String tabId) {
    final webViewTab = webViewTabs.firstWhere(
      (tab) => tab.tabId == tabId,
    );
    _closeWebViewTab(webViewTab);
  }

  void loadUrlToTab(String url) {
    final webViewTab = webViewTabs[currentTabIndex.value];
    webViewTab.loadUrl(url);
  }
}
