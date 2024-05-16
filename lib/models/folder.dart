import 'package:uuid/uuid.dart';
import 'space_item_tree_node.dart';

class Folder extends SpaceItemTreeNode {
  Folder({
    required super.name,
    super.children = const [],
  }) : super(
          id: const Uuid().v4(),
          type: SpaceItemTreeNodeType.folder,
        );

  @override
  dynamic get specificData => null;

  bool isActivated = false; // DB에는 저장되지 않는다.
}
