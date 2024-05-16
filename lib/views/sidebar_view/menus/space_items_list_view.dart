import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:orbit/models/space.dart';
import 'package:orbit/models/space_item_tree_node.dart';

class SpaceItemsTreeView extends StatelessWidget {
  const SpaceItemsTreeView({
    super.key,
    required this.space,
  });
  final Space space;

  @override
  Widget build(BuildContext context) {
    // final List<SpaceItemTreeNode> roots = [
    //   space,
    // ];
    // final treeController = TreeController<SpaceItemTreeNode>(
    //   roots: roots,
    //   childrenProvider: (SpaceItemTreeNode node) => node.children,
    //   // parentProvider: (SpaceItemTreeNode node) => roots.contains(node) ? null : node.parent,
    // );
    return Container(
      margin: const EdgeInsets.only(bottom: 45.0),
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('Entry C')),
          ),
        ],
      ),
      // ListView.builder(
      //   itemCount: space.items.length,
      //   itemBuilder: (context, index) {
      //     final item = space.items[index];
      //     return ListTile(
      //       title: Text(item.title),
      //       subtitle: Text(item.description),
      //       leading: Icon(item.icon),
      //       onTap: () {
      //         // Handle item tap
      //       },
      //     );
      //   },
      // )
    );
  }
}
