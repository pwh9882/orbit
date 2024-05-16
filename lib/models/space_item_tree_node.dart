import 'package:get/get.dart';
import 'package:orbit/services/db/space_item_tree_node_dao.dart';

abstract class SpaceItemTreeNode {
  SpaceItemTreeNode({
    required this.id,
    required this.type,
    required this.name,
    Iterable<SpaceItemTreeNode>? children,
  }) : _children = <SpaceItemTreeNode>[] {
    if (children == null) return;

    for (final SpaceItemTreeNode child in children) {
      child._parent = this;
      _children.add(child);
    }
  }

  String id;
  SpaceItemTreeNodeType type;
  String name;
  final List<SpaceItemTreeNode> _children;
  Iterable<SpaceItemTreeNode> get children => _children;
  bool get isLeaf => _children.isEmpty;

  SpaceItemTreeNode? get parent => _parent;
  SpaceItemTreeNode? _parent;

  int get index => _parent?._children.indexOf(this) ?? -1;

  Future<void> insertChild(int index, SpaceItemTreeNode node) async {
    final spaceItemDAO = Get.find<SpaceItemDAO>();

    // Adjust the index if necessary when dropping a node at the same parent
    if (node._parent == this && node.index < index) {
      index--;
    }

    // Remove the node from its previous parent if it exists
    if (node._parent != null) {
      node._parent?._children.remove(node);
      spaceItemDAO.updateNodeParent(node.id, id);
    } else {
      // Insert the node into the database
      spaceItemDAO.insertNode(node, parentId: id);
    }

    // Update the node's parent
    node._parent = this;

    // Insert the node into the new parent's children list
    _children.insert(index, node);
  }

  dynamic get specificData; // 각 노드 타입에 특화된 데이터를 반환하는 추상 프로퍼티
}

enum SpaceItemTreeNodeType { space, tab, folder, boardTab }
