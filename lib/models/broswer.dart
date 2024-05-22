import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/models/folder.dart';
import 'package:orbit/models/space.dart';
import 'package:orbit/models/tab.dart';
import 'package:orbit/models/url_parser.dart';
import 'package:orbit/services/db/space_item_tree_node_dao.dart';
import 'package:orbit/views/content_view/webivew.dart';

class Broswer extends GetxController {
  final dao = Get.find<SpaceItemDAO>();

  var spaces = [].obs;
  var currentSpaceIndex = 0.obs;

  PageController? pageviewController;

  WebViewTabController? webviewController;

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

    currentSpaceIndex.value = spaces.length - 1;

    pageviewController?.animateToPage(
      currentSpaceIndex.value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  Future<void> createFolderToCurrentSpace(String name) async {
    Space currentSpace = spaces[currentSpaceIndex.value];
    final newFolder = Folder(name: name, children: []);
    // await dao.insertNode(newFolder,
    //     parentId: currentSpace.id, index: currentSpace.children.length);

    currentSpace.insertChild(currentSpace.children.length, newFolder);
    currentSpace.treeController?.rebuild();
  }

  Future<void> createTabToCurrentSpace(String userInput) async {
    Space currentSpace = spaces[currentSpaceIndex.value];
    // var urlPaswer = UrlParser();
    var url = UrlParser().parse(userInput);

    final newTab = TabNode(name: url, url: url);
    // await dao.insertNode(newTab,
    //     parentId: currentSpace.id, index: currentSpace.children.length);
    // debugPrint(currentSpace.children.length.toString());

    currentSpace.insertChild(currentSpace.children.length, newTab);
    currentSpace.treeController?.rebuild();
  }

  Future<void> renameSpace(String name) async {
    Space currentSpace = spaces[currentSpaceIndex.value];
    currentSpace.name = name;
    await dao.updateNode(currentSpace);
  }

  Future<void> deleteCurrentSpace() async {
    Space space = spaces[currentSpaceIndex.value];
    await dao.deleteNode(space.id);
    spaces.remove(space);
    currentSpaceIndex.value = max(0, currentSpaceIndex.value - 1);
    pageviewController?.animateToPage(
      currentSpaceIndex.value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
