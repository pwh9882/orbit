import 'package:flutter/material.dart';
import 'package:orbit/models/space.dart';

class SpaceItemsListView extends StatelessWidget {
  const SpaceItemsListView({
    super.key,
    required this.space,
  });
  final Space space;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Text('Space Items List View \n${space.name}'),
    );
  }
}
