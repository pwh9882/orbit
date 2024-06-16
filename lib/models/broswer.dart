import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:get/get.dart';
import 'package:orbit/models/folder.dart';
import 'package:orbit/models/space.dart';
import 'package:orbit/models/tab.dart';
import 'package:orbit/models/url_parser.dart';
import 'package:orbit/models/webview_tab_viewer_contorller.dart';
import 'package:orbit/services/db/space_item_tree_node_dao.dart';

class Broswer extends GetxController {
  final dao = Get.find<SpaceItemDAO>();

  var spaces = [].obs;
  var currentSpaceIndex = 0.obs;

  PageController? pageviewController;
  TreeController? treeController;

  WebviewTabViewerController webviewTabViewerController = Get.find();

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

    // currentSpaceIndex.value = spaces.length - 1;

    pageviewController?.animateToPage(
      // currentSpaceIndex.value,
      spaces.length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
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
      // currentSpaceIndex.value,
      max(0, currentSpaceIndex.value - 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  Future<void> onFocusingSpaceChanged(int newIndex) async {
    Space previousSpace = spaces[currentSpaceIndex.value];
    if (previousSpace.currentSelectedTab != null) {
      previousSpace.currentSelectedTab!.isSeleted = false;
    }
    currentSpaceIndex.value = newIndex;

    Space currentSpace = spaces[currentSpaceIndex.value];
    if (currentSpace.currentSelectedTab != null) {
      selectTab(currentSpace.currentSelectedTab!);
    } else {
      webviewTabViewerController.currentTabIndex.value = -1;
    }
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
    var url = UrlParser().parse(userInput);

    final newTab = TabNode(name: url, url: url);

    currentSpace.insertChild(currentSpace.children.length, newTab);
    currentSpace.treeController?.rebuild();

    selectTab(newTab);
    // currentSpace.currentSelectedTab = newTab;
    // webviewTabViewerController.addWebViewTab(tabId: newTab.id, url: url);
  }

  void selectTab(TabNode tab) {
    Space currentSpace = spaces[currentSpaceIndex.value];

    currentSpace.currentSelectedTab?.isSeleted = false;

    currentSpace.currentSelectedTab = tab;
    tab.isSeleted = true;

    if (tab.isActivated) {
      webviewTabViewerController.selectWebViewTabByTabId(tab.id);
    } else {
      tab.isActivated = true;
      webviewTabViewerController.addWebViewTab(tabId: tab.id, url: tab.url);
    }
  }

  Future<void> closeTab(TabNode tab) async {
    Space currentSpace = spaces[currentSpaceIndex.value];
    tab.isActivated = false;
    currentSpace.currentSelectedTab = null;

    webviewTabViewerController.closeWebViewTabByTabId(tab.id);
    treeController?.rebuild();
  }

  Future<void> renameTab(TabNode tab, String newName) async {
    tab.name = newName;
    await dao.updateNode(tab);
  }

  // Future<void> deleteTab(TabNode tab) async {
  //   webviewTabViewerController.closeWebViewTabByTabId(tab.id);
  // }
  Future<bool> goBackWebviewTab() async {
    if (webviewTabViewerController.currentTabIndex.value != -1) {
      var currentTab = webviewTabViewerController
          .webViewTabs[webviewTabViewerController.currentTabIndex.value];
      if (await currentTab.canGoBack()) {
        currentTab.goBack();
      } else {
        closeTab(
            (spaces[currentSpaceIndex.value] as Space).currentSelectedTab!);
        // webivewTabViewerController.closeWebViewTab(currentTab);
        // broswer.spaces[broswer.currentSpaceIndex.value]
        //     .currentSelectedTab = null;
      }
      return true;
    }
    return false;
  }
}
