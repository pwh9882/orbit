import 'package:orbit/models/space_item_tree_node.dart';
import 'package:uuid/uuid.dart';

class Tab implements SpaceItemTreeNode {
  @override
  String id;
  @override
  final SpaceItemTreeNodeType type = SpaceItemTreeNodeType.tab;
  @override
  final String name;
  @override
  final List<SpaceItemTreeNode>? children = null;

  String url;

  Tab({
    required this.name,
    required this.url,
  }) : id = const Uuid().v4();

  @override
  dynamic get specificData => url;

  bool isActivated = false; // DB에는 저장되지 않는다.
}
