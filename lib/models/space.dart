import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:orbit/models/tab.dart';
import 'package:uuid/uuid.dart';
import 'space_item_tree_node.dart';

class Space extends SpaceItemTreeNode {
  Space({
    required super.name,
    super.children = const [],
  }) : super(
          id: const Uuid().v4(),
          type: SpaceItemTreeNodeType.space,
        );

  TreeController<SpaceItemTreeNode>? treeController;

  @override
  dynamic get specificData => null;

  TabNode? currentSelectedTab;
}
