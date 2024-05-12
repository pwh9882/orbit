import 'package:flutter/material.dart';

class SpaceItemsListView extends StatelessWidget {
  const SpaceItemsListView({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Text('Space Items List View $index'),
    );
  }
}
