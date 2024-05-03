import 'dart:convert';

import 'package:orbit/models/space_item.dart';
import 'package:uuid/uuid.dart';

class Folder implements SpaceItem {
  @override
  final String id;
  @override
  String name;

  @override
  bool isActivated = false;

  // db에 저장되될 때는 id값만 저장됨.
  List<SpaceItem> items = [];

  Folder({
    required this.id,
    required this.name,
    this.items = const [],
  });

  @override
  SpaceItemType get type => SpaceItemType.folder;

  Folder createNewFolder({
    String name = 'new Folder',
  }) {
    var uuid = const Uuid();
    String newFolderId = uuid.v4(); // Generates a unique UUID
    return Folder(
      id: newFolderId,
      name: name,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type':
          SpaceItemType.folder.toString(), // 'folder' -> 'SpaceItemType.folder
      'name': name,
      'items': jsonEncode(items.map((item) => item.toMap()).toList()),
    };
  }
}
