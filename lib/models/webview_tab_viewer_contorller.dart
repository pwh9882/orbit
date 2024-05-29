import 'package:get/get.dart';
import 'package:orbit/views/content_view/webivew_tab.dart';

const kHomeUrl = 'https://google.com';

class WebviewTabViewerController extends GetxController {
  final webViewTabs = <WebViewTab>[].obs;
  final currentTabIndex = 0.obs;

  WebViewTab createWebViewTab(
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
        .add(createWebViewTab(tabId: tabId, url: url, windowId: windowId));

    // setState(() {
    //   currentTabIndex = webViewTabs.length - 1;
    // });
    currentTabIndex.value = webViewTabs.length - 1;
  }

  void selectWebViewTabByTabId(String tabId) {
    final webViewTab = webViewTabs.firstWhere((tab) => tab.tabId == tabId);
    _selectWebViewTab(webViewTab);
  }

  void _selectWebViewTab(WebViewTab webViewTab) {
    final webViewIndex = webViewTabs.indexOf(webViewTab);
    webViewTabs[currentTabIndex.value].controller.pause();
    webViewTab.controller.resume();
    // setState(() {
    //   currentTabIndex = webViewIndex;
    //   showWebViewTabsViewer = false;
    // });
    currentTabIndex.value = webViewIndex;
  }

  void closeWebViewTabByTabId(String tabId) {
    try {
      final webViewTab = webViewTabs.firstWhere(
        (tab) => tab.tabId == tabId,
      );

      _closeWebViewTab(webViewTab);
    } catch (e) {
      // tabId에 해당하는 탭을 찾지 못했을 때의 처리
    }
  }

  void _closeWebViewTab(WebViewTab webViewTab) {
    final webViewIndex = webViewTabs.indexOf(webViewTab);
    webViewTabs.remove(webViewTab);
    if (currentTabIndex > webViewIndex) {
      currentTabIndex.value--;
    }
    // if (webViewTabs.isEmpty) {
    //   webViewTabs.add(createWebViewTab());
    //   currentTabIndex = 0;
    // }
    // setState(() {
    //   currentTabIndex = max(0, min(webViewTabs.length - 1, currentTabIndex));
    // });
    currentTabIndex.value =
        currentTabIndex.value.clamp(0, webViewTabs.length - 1);
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