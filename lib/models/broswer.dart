import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:orbit/models/folder.dart';
import 'package:orbit/models/space.dart';
import 'package:orbit/models/tab.dart';
import 'package:orbit/services/db/space_item_tree_node_dao.dart';

class Broswer extends GetxController {
  final dao = Get.find<SpaceItemDAO>();

  var spaces = [].obs;
  var currentSpaceIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await loadInitialTree().then((value) => spaces.addAll(value));
  }

  //getSpaceTree: 각 Space 노드에 대해 전체 트리 구조를 가져옵니다.
  Future<List<Space>> loadInitialTree() async {
    final spaces = await dao.getAllSpaces();
    for (final space in spaces) {
      // final fullTree =
      await dao.getSpaceTree(space);
      // `fullTree`를 원하는 데이터 구조에 맞게 사용하거나 UI에 적용합니다.
    }
    // print(spaces.length);
    return spaces;
  }

  // 최상위 Space 노드를 추가하는 경우에는 insertNode를 사용하여 루트 노드를 삽입합니다.
  Future<void> createSpace(String name) async {
    final newSpace = Space(name: name, children: []);
    await dao.insertNode(newSpace, index: spaces.length);
    spaces.add(newSpace);
  }

  Future<void> createFolderToCurrentSpace(String name) async {
    Space currentSpace = spaces[currentSpaceIndex.value];
    final newFolder = Folder(name: name, children: []);
    // await dao.insertNode(newFolder,
    //     parentId: currentSpace.id, index: currentSpace.children.length);

    currentSpace.insertChild(currentSpace.children.length, newFolder);
    currentSpace.treeController?.rebuild();
  }

  Future<void> createTabToCurrentSpace(String name, String url) async {
    Space currentSpace = spaces[currentSpaceIndex.value];
    final newTab = TabNode(name: name, url: url);
    // await dao.insertNode(newTab,
    //     parentId: currentSpace.id, index: currentSpace.children.length);
    // debugPrint(currentSpace.children.length.toString());

    currentSpace.insertChild(currentSpace.children.length, newTab);
    currentSpace.treeController?.rebuild();
  }
}
