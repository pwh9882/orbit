import 'package:flutter/material.dart';
import 'package:orbit/views/sidebar_view/empty_page.dart';
import 'package:orbit/views/sidebar_view/menus/menu_search_bar.dart';
import 'package:orbit/views/sidebar_view/menus/menu_shortcut_bar.dart';
import 'package:orbit/views/sidebar_view/menus/menu_space_page_indicator.dart';
import 'package:orbit/views/sidebar_view/menus/menu_space_page_view.dart';

// a map of ("page name", WidgetBuilder) pairs
final _availablePages = <String, WidgetBuilder>{
  'First Page': (_) => const EmptyPage(),
  'Second Page': (_) => const EmptyPage(),
};

class SidebarView extends StatelessWidget {
  const SidebarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Menu')),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: const Padding(
        padding: EdgeInsets.only(top: 25.0),
        child: Column(
          children: [
            MenuSearchBar(),
            Expanded(child: MenuSpacePageView()),
            MenuSpacePageIndicator(),
            MenuShortcutBar(),
          ],
        ),
      ),
    );
  }
}

class PageListTile extends StatelessWidget {
  const PageListTile({
    super.key,
    this.selectedPageName,
    required this.pageName,
    this.onPressed,
  });
  final String? selectedPageName;
  final String pageName;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // show a check icon if the page is currently selected
      // note: we use Opacity to ensure that all tiles have a leading widget
      // and all the titles are left-aligned
      leading: Opacity(
        opacity: selectedPageName == pageName ? 1.0 : 0.0,
        child: const Icon(Icons.check),
      ),
      title: Text(pageName),
      onTap: onPressed,
    );
  }
}
