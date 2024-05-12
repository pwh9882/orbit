import 'package:orbit/models/space_item_tree_node.dart';
import 'package:uuid/uuid.dart';

class Folder implements SpaceItemTreeNode {
  @override
  String id;
  @override
  final SpaceItemTreeNodeType type = SpaceItemTreeNodeType.folder;
  @override
  final String name;
  @override
  final List<SpaceItemTreeNode> children;

  Folder({
    required this.name,
    this.children = const [],
  }) : id = const Uuid().v4();

  @override
  dynamic get specificData => null;

  bool isActivated = false; // DB에는 저장되지 않는다.
}
