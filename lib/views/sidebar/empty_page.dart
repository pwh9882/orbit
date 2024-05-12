// https://codewithandrea.com/articles/flutter-responsive-layouts-split-view-drawer-navigation/
// Just a simple placeholder widget page
// (in a real app you'd have something more interesting)
import 'package:flutter/material.dart';
import 'package:orbit/views/sidebar/page_scaffold.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'First Page',
      body: Center(
        child: Text('First Page',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
