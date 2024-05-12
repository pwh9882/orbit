import 'package:flutter/material.dart';
import 'package:orbit/views/sidebar_view/menus/menu_search_bar.dart';
import 'package:orbit/views/sidebar_view/menus/menu_shortcut_bar.dart';
import 'package:orbit/views/sidebar_view/menus/menu_space_page_view.dart';

class SidebarView extends StatelessWidget {
  const SidebarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Menu')),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Column(
          children: [
            const MenuSearchBar(),
            Expanded(
              child: MenuSpacePageView(),
            ),
            const MenuShortcutBar(),
          ],
        ),
      ),
    );
  }
}
