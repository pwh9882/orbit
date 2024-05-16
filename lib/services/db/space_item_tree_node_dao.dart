import 'package:get/get.dart';
import 'package:orbit/models/folder.dart';
import 'package:orbit/models/space.dart';
import 'package:orbit/models/space_item_tree_node.dart';
import 'package:orbit/models/tab.dart';
import 'package:sqflite/sqflite.dart';
import 'database_manager.dart';

class SpaceItemDAO extends GetxService {
  final DatabaseManager _databaseManager = DatabaseManager.instance;

  Future<void> insertNode(SpaceItemTreeNode node, {String? parentId}) async {
    final db = await _databaseManager.database;

    await db.insert(
      'spaceItemTreeNodes',
      {
        'id': node.id,
        'type': node.type.toString().split('.').last,
        'name': node.name,
        'specificData': node.specificData?.toString(),
        'parentId': parentId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // 자식 노드도 재귀적으로 삽입
    for (final child in node.children) {
      await insertNode(child, parentId: node.id);
    }
  }

  Future<void> updateNodeParent(String nodeId, String newParentId) async {
    final db = await _databaseManager.database;

    await db.update(
      'spaceItemTreeNodes',
      {
        'parentId': newParentId,
      },
      where: 'id = ?',
      whereArgs: [nodeId],
    );
  }

  Future<SpaceItemTreeNode?> getNodeById(String id) async {
    final db = await _databaseManager.database;

    final maps = await db.query(
      'spaceItemTreeNodes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return _mapToNode(maps.first);
    }

    return null;
  }

  Future<List<SpaceItemTreeNode>> getChildren(String parentId) async {
    final db = await _databaseManager.database;

    final maps = await db.query(
      'spaceItemTreeNodes',
      where: 'parentId = ?',
      whereArgs: [parentId],
    );

    return maps.map((map) => _mapToNode(map)).toList();
  }

  Future<void> updateNode(SpaceItemTreeNode node) async {
    final db = await _databaseManager.database;

    await db.update(
      'spaceItemTreeNodes',
      {
        'name': node.name,
        'specificData': node.specificData?.toString(),
      },
      where: 'id = ?',
      whereArgs: [node.id],
    );
  }

  Future<void> deleteNode(String id) async {
    final db = await _databaseManager.database;

    await db.delete(
      'spaceItemTreeNodes',
      where: 'id = ?',
      whereArgs: [id],
    );

    // 자식 노드도 재귀적으로 삭제
    final children = await getChildren(id);
    for (final child in children) {
      await deleteNode(child.id);
    }
  }

  SpaceItemTreeNode _mapToNode(Map<String, dynamic> map) {
    final type = SpaceItemTreeNodeType.values.firstWhere(
      (e) => e.toString().split('.').last == map['type'],
    );

    switch (type) {
      case SpaceItemTreeNodeType.space:
        return Space(
          name: map['name'],
          children: [], // 자식 노드를 나중에 설정해야 함
        )..id = map['id'];
      case SpaceItemTreeNodeType.folder:
        return Folder(
          name: map['name'],
          children: [],
        )..id = map['id'];
      case SpaceItemTreeNodeType.tab:
        return TabNode(
          name: map['name'],
          url: map['specificData'],
        )..id = map['id'];
      default:
        throw Exception('Unknown node type: $type');
    }
  }

  // get all space aka root nodes
  Future<List<Space>> getAllSpaces() async {
    final db = await _databaseManager.database;

    final maps = await db.query(
      'spaceItemTreeNodes',
      where: 'type = ?',
      whereArgs: [SpaceItemTreeNodeType.space.toString().split('.').last],
    );

    if (maps.isEmpty) {
      // If no spaces found, add a default space and return it
      final defaultSpace = Space(
        name: 'Default Space',
        children: [],
      );
      await insertNode(defaultSpace);
      return [defaultSpace];
    }

    return maps.map((map) {
      return Space(
        name: map['name'] as String,
        children: [], // 자식 노드를 나중에 설정해야 함
      )..id = map['id'] as String;
    }).toList();
  }

  // 재귀적으로 자식 노드를 가져와 트리를 완성하는 메서드
  Future<void> _populateChildren(SpaceItemTreeNode node) async {
    final childrenNodes = await getChildren(node.id);

    for (final childNode in childrenNodes) {
      // 각 노드의 타입에 따라 추가하며, 재귀적으로 자식 노드도 수집
      if (node is Space || node is Folder) {
        node.insertChild(node.children.length, childNode);
        await _populateChildren(childNode);
      } else {
        throw Exception('Unsupported node type for children: ${node.type}');
      }
    }
  }

  // 루트 노드(Space)를 기반으로 트리 전체를 가져옴
  Future<SpaceItemTreeNode> getSpaceTree(Space space) async {
    await _populateChildren(space);

    return space;
  }
}
