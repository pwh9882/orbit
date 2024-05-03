import 'package:flutter/material.dart';
import 'package:orbit/models/space_item.dart';
import 'package:uuid/uuid.dart';

class Tab implements SpaceItem {
  @override
  final String id;
  @override
  String name;
  String url;

  // webview를 활성화했는지 여부, db에 저장되지 않음.
  @override
  bool isActivated = false;
  // WebViewTabScreen? webviewTabScreen;

  // webview의 key, webview 찾기 위해 사용, db에 저장되지 않음.
  GlobalKey? webViewKey;

  Tab({
    required this.id,
    required this.name,
    required this.url,
  });

  @override
  SpaceItemType get type => SpaceItemType.tab;

  static Tab createNewTab({
    String name = 'new Tab',
    String url = 'www.google.com',
  }) {
    var uuid = const Uuid();
    String newTabId = uuid.v4(); // Generates a unique UUID
    return Tab(
      id: newTabId,
      name: name,
      url: url,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': SpaceItemType.tab.toString(), // 'tab' -> 'SpaceItemType.tab
      'name': name,
      'url': url,
    };
  }
}
