import 'package:orbit/models/folder.dart';
import 'package:orbit/models/space.dart';
import 'package:orbit/models/space_item_tree_node.dart';
import 'package:orbit/models/tab.dart';
import 'package:orbit/services/db/space_item_tree_node_dao.dart';

//getSpaceTree: 각 Space 노드에 대해 전체 트리 구조를 가져옵니다.
Future<List<Space>> loadInitialTree() async {
  final dao = SpaceItemDAO();
  final spaces = await dao.getAllSpaces();
  for (final space in spaces) {
    final fullTree = await dao.getSpaceTree(space);
    // `fullTree`를 원하는 데이터 구조에 맞게 사용하거나 UI에 적용합니다.
  }
  return spaces;
}

// 최상위 Space 노드를 추가하는 경우에는 insertNode를 사용하여 루트 노드를 삽입합니다.
Future<void> addRootNode(String name) async {
  final dao = SpaceItemDAO();
  final newSpace = Space(name: name, children: []);
  await dao.insertNode(newSpace);
}

// 특정 노드의 자식으로 추가할 때는 insertNode 함수에 parentId를 명시하여 자식 노드를 삽입합니다.
Future<void> addChildNode(
    SpaceItemTreeNode parent, String nodeName, SpaceItemTreeNodeType nodeType,
    {String? url}) async {
  final dao = SpaceItemDAO();
  SpaceItemTreeNode newNode;

  if (nodeType == SpaceItemTreeNodeType.folder) {
    newNode = Folder(name: nodeName, children: []);
  } else if (nodeType == SpaceItemTreeNodeType.tab) {
    if (url == null) throw Exception('URL is required for Tab nodes.');
    newNode = TabNode(name: nodeName, url: url);
  } else {
    throw Exception('Unsupported node type for addition: $nodeType');
  }

  await dao.insertNode(newNode, parentId: parent.id);
}

// 노드의 이름이나 특정 데이터를 수정할 때에는 updateNode를 사용합니다.
Future<void> updateNodeDetails(SpaceItemTreeNode node, String newName,
    {String? newUrl}) async {
  final dao = SpaceItemDAO();

  if (node is Folder) {
    final updatedFolder = Folder(name: newName, children: node.children)
      ..id = node.id;
    await dao.updateNode(updatedFolder);
  } else if (node is TabNode) {
    final updatedTab = TabNode(name: newName, url: newUrl ?? node.url)
      ..id = node.id;
    await dao.updateNode(updatedTab);
  } else if (node is Space) {
    final updatedSpace = Space(name: newName, children: node.children)
      ..id = node.id;
    await dao.updateNode(updatedSpace);
  } else {
    throw Exception('Unsupported node type for update: ${node.type}');
  }
}

//노드를 삭제할 때에는 deleteNode 함수를 사용합니다. 이 함수는 재귀적으로 자식 노드들도 삭제합니다.
Future<void> deleteNode(SpaceItemTreeNode node) async {
  final dao = SpaceItemDAO();
  await dao.deleteNode(node.id);
}

///5. 트리 업데이트 시나리오
// 트리 뷰에서 수정이 일어날 때의 시나리오를 요약하면 다음과 같습니다.
// 첫 로딩
// getAllSpaces로 모든 루트 노드를 가져옵니다.
// 각 Space 노드에 대해 getSpaceTree를 호출하여 트리 구조를 완성합니다.

Future<void> loadInitialTreeStructure() async {
  final dao = SpaceItemDAO();
  final spaces = await dao.getAllSpaces();
  for (final space in spaces) {
    await dao.getSpaceTree(space);
  }
}

// 노드 추가

// 루트 노드 추가: 새로운 Space 노드를 추가합니다.
// 자식 노드 추가: 특정 부모 노드에 자식 노드를 추가합니다.
Future<void> addNewSpace(String name) async {
  final dao = SpaceItemDAO();
  final newSpace = Space(name: name, children: []);
  await dao.insertNode(newSpace);
}
