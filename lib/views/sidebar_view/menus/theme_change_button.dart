import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/views/controllers/theme_controller.dart';
import 'package:orbit/themes/theme.dart';

class ThemeChangeButton extends StatelessWidget {
  final themeController = Get.find<ThemeController>();

  ThemeChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeController.theme == ThemeMode.dark;
    const materialTheme = MaterialTheme(TextTheme());
    return IconButton(
      icon: Icon(
          isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          color: Theme.of(context).colorScheme.onBackground),
      onPressed: () {
        // debugPrint('Get.isDarkMode: ${Get.isDarkMode}');
        if (isDarkMode) {
          themeController.saveTheme(false);
          Get.changeTheme(materialTheme.light());
          Get.changeThemeMode(ThemeMode.light);
        } else {
          themeController.saveTheme(true);
          themeController.changeTheme(materialTheme.dark());
        }
      },
    );
  }
}
