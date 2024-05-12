abstract class SpaceItemTreeNode {
  String get id;
  SpaceItemTreeNodeType get type;
  String get name;
  List<SpaceItemTreeNode>? get children;

  dynamic get specificData; // 각 노드 타입에 특화된 데이터를 반환하는 추상 프로퍼티
}

enum SpaceItemTreeNodeType { space, tab, folder, boardTab }
