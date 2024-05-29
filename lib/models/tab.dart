import 'package:uuid/uuid.dart';
import 'space_item_tree_node.dart';

class TabNode extends SpaceItemTreeNode {
  final String url;

  TabNode({
    required super.name,
    required this.url,
  }) : super(
          id: const Uuid().v4(),
          type: SpaceItemTreeNodeType.tab,
          children: [],
        );

  @override
  dynamic get specificData => url;

  bool isActivated = false; // DB에는 저장되지 않는다.
  bool isSeleted = false; // DB에는 저장되지 않는다.
}
