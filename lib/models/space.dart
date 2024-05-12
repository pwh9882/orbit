import 'package:orbit/models/space_item_tree_node.dart';
import 'package:uuid/uuid.dart';

class Space implements SpaceItemTreeNode {
  @override
  String id;
  @override
  final SpaceItemTreeNodeType type = SpaceItemTreeNodeType.space;
  @override
  final String name;
  @override
  final List<SpaceItemTreeNode> children;

  Space({
    required this.name,
    this.children = const [],
  }) : id = const Uuid().v4();

  @override
  dynamic get specificData => null;
}
