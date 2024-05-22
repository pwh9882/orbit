import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/models/broswer.dart';
import 'package:orbit/views/content_view/webivew.dart';
import 'package:orbit/views/sidebar_view/empty_page.dart';

class ContentView extends StatelessWidget {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyPage();
    final broswer = Get.find<Broswer>();
    final webviewController = WebViewTabController();
    broswer.webviewController = webviewController;
    return WebViewTabScreen(
      url: "about:blank",
      controller: webviewController,
      onCloseTabRequested: () {},
      onCreateTabRequested: (createWindowAction) {},
    );
  }
}
