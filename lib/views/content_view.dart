import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/views/sidebar/empty_page.dart';

class ContentView extends StatelessWidget {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      body: const Center(child: EmptyPage()),
    );
  }
}
