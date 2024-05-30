import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewTabController extends GetxController {
  Rx<Uint8List?> screenshot = Rx<Uint8List?>(null);
  Rx<String> url = ''.obs;
  Rx<bool?> isSecure = Rx<bool?>(null);
  Rx<String> title = ''.obs;
  Rx<Favicon?> favicon = Rx<Favicon?>(null);
  Rx<double> progress = 0.0.obs;
  InAppWebViewController? webViewController;

  void updateState() {
    update();
  }

  Future<void> updateScreenshot() async {
    screenshot.value = await webViewController
        ?.takeScreenshot(
            screenshotConfiguration: ScreenshotConfiguration(
                compressFormat: CompressFormat.JPEG, quality: 20))
        .timeout(
          const Duration(milliseconds: 1500),
          onTimeout: () => null,
        );
  }

  Future<void> pause() async {
    // return;
    if (!kIsWeb) {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        await webViewController?.setAllMediaPlaybackSuspended(suspended: true);
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        await webViewController?.pause();
      }
    }
  }

  Future<void> resume() async {
    if (!kIsWeb) {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        await webViewController?.setAllMediaPlaybackSuspended(suspended: false);
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        await webViewController?.resume();
      }
    }
  }

  Future<bool> canGoBack() async {
    return await webViewController?.canGoBack() ?? false;
  }

  Future<void> goBack() async {
    if (await canGoBack()) {
      await webViewController?.goBack();
    }
  }

  Future<bool> canGoForward() async {
    return await webViewController?.canGoForward() ?? false;
  }

  Future<void> goForward() async {
    if (await canGoForward()) {
      await webViewController?.goForward();
    }
  }

  static bool urlIsSecure(Uri url) {
    return (url.scheme == "https") || isLocalizedContent(url);
  }

  static bool isLocalizedContent(Uri url) {
    return (url.scheme == "file" ||
        url.scheme == "chrome" ||
        url.scheme == "data" ||
        url.scheme == "javascript" ||
        url.scheme == "about");
  }
}

class WebViewTab extends StatelessWidget {
  final String tabId;
  final String? url;
  final int? windowId;
  final WebViewTabController controller;
  // final Function() onStateUpdated;
  final Function(CreateWindowAction createWindowAction) onCreateTabRequested;
  final Function() onCloseTabRequested;

  const WebViewTab({
    super.key,
    required this.url,
    required this.controller,
    // required this.onStateUpdated,
    required this.onCloseTabRequested,
    required this.onCreateTabRequested,
    this.windowId,
    required this.tabId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebViewTabController>(
      init: controller,
      builder: ((controller) {
        return Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: Colors.transparent,
                  ),
                  InAppWebView(
                    windowId: windowId,
                    initialUrlRequest:
                        url != null ? URLRequest(url: WebUri(url!)) : null,
                    initialSettings: InAppWebViewSettings(
                      javaScriptCanOpenWindowsAutomatically: true,
                      supportMultipleWindows: true,
                      isFraudulentWebsiteWarningEnabled: true,
                      safeBrowsingEnabled: true,
                      mediaPlaybackRequiresUserGesture: false,
                      allowsInlineMediaPlayback: true,
                    ),
                    onWebViewCreated: (webViewController) async {
                      controller.webViewController = webViewController;
                      if (!kIsWeb &&
                          defaultTargetPlatform == TargetPlatform.android) {
                        await webViewController.startSafeBrowsing();
                      }
                    },
                    onLoadStart: (webViewController, uri) {
                      controller.favicon.value = null;
                      controller.title.value = '';
                      if (uri != null) {
                        controller.url.value = uri.toString();
                        controller.isSecure.value =
                            WebViewTabController.urlIsSecure(uri);
                      }
                      controller.updateState();
                    },
                    onLoadStop: (webViewController, uri) async {
                      // controller.updateScreenshot();

                      if (uri != null) {
                        final sslCertificate =
                            await webViewController.getCertificate();
                        controller.url.value = uri.toString();
                        controller.isSecure.value = sslCertificate != null ||
                            WebViewTabController.urlIsSecure(uri);
                      }

                      final favicons = await webViewController.getFavicons();
                      if (favicons.isNotEmpty) {
                        for (final favicon in favicons) {
                          if (controller.favicon.value == null) {
                            controller.favicon.value = favicon;
                          } else if (favicon.width != null &&
                              (favicon.width ?? 0) >
                                  (controller.favicon.value?.width ?? 0)) {
                            controller.favicon.value = favicon;
                          }
                        }
                      }

                      controller.updateState();
                    },
                    onUpdateVisitedHistory: (webViewController, uri, isReload) {
                      if (uri != null) {
                        controller.url.value = uri.toString();
                        controller.updateState();
                      }
                    },
                    onTitleChanged: (webViewController, title) {
                      controller.title.value = title ?? '';
                      controller.updateState();
                    },
                    onProgressChanged: (webViewController, progress) {
                      controller.progress.value = progress / 100;
                    },
                    onCreateWindow:
                        (webViewController, createWindowAction) async {
                      onCreateTabRequested(createWindowAction);
                      return true;
                    },
                    onCloseWindow: (webViewController) {
                      onCloseTabRequested();
                    },
                  ),
                  controller.progress < 1.0
                      ? LinearProgressIndicator(
                          value: controller.progress.value,
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
