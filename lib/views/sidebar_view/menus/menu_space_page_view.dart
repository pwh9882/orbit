import 'package:flutter/material.dart';
import 'package:orbit/views/sidebar_view/menus/space_items_list_view.dart';

class MenuSpacePageView extends StatelessWidget {
  const MenuSpacePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView(
          children: const [
            SpaceItemsListView(index: 0),
            SpaceItemsListView(index: 1),
            SpaceItemsListView(index: 2),
          ],
        ),
      ],
    );
  }
}
