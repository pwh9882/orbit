import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orbit/controllers/custom_drawer_controller.dart';
import 'package:orbit/controllers/theme_controller.dart';
import 'package:orbit/views/content_view.dart';
import 'package:orbit/views/sidebar/sidebar_view.dart';
import 'package:orbit/views/split_view.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeController = Get.put(ThemeController());
  final drawerController = Get.put(CustomDrawerController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Orbit',
      theme: themeController.materialTheme.light(),
      darkTheme: themeController.materialTheme.dark(),
      themeMode: themeController.themeMode,
      home: const SplitView(
        menu: SidebarView(),
        content: ContentView(),
      ),
    );
  }
}
