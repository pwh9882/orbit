import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orbit/controllers/theme_controller.dart';
import 'package:orbit/models/broswer.dart';
import 'package:orbit/models/webview_tab_viewer_contorller.dart';
import 'package:orbit/services/db/space_item_tree_node_dao.dart';
import 'package:orbit/views/content_view/content_view.dart';
import 'package:orbit/views/sidebar_view/sidebar_view.dart';
import 'package:orbit/views/split_view.dart';

void main() async {
  // it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Get.putAsync(() async => SpaceItemDAO());
  await Get.putAsync(() async => WebviewTabViewerController());
  await Get.putAsync(() async => Broswer());
  // SpaceItemDAO 인스턴스를 GetX 싱글톤으로 초기화
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Orbit',
      theme: themeController.materialTheme.light(),
      darkTheme: themeController.materialTheme.dark(),
      themeMode: themeController.theme,
      home: const SplitView(
        menu: SidebarView(),
        content: ContentView(),
      ),
    );
  }
}
