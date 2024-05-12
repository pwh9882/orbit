import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/views/sidebar_view/menus/theme_change_button.dart';

class MenuShortcutBar extends StatelessWidget {
  const MenuShortcutBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.colorScheme.onSecondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // IconButton(
          //   // bookmark
          //   onPressed: () {
          //     // TODO: implement onPressed
          //   },
          //   icon: Icon(
          //     Icons.bookmark_outlined,
          //     color: context.theme.colorScheme.onBackground,
          //   ),
          // ),
          // IconButton(
          //   // history
          //   onPressed: () {
          //     // TODO: implement onPressed
          //   },
          //   icon: Icon(
          //     Icons.history_outlined,
          //     color: context.theme.colorScheme.onBackground,
          //   ),
          // ),
          ThemeChangeButton(),
          IconButton(
            // settings
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
          IconButton(
            // back
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_rounded,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
          IconButton(
            // forward
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward_rounded,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
          IconButton(
            // refresh
            onPressed: () {},
            icon: Icon(
              Icons.refresh_rounded,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
