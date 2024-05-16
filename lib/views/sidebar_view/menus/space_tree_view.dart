import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:get/get.dart';
import 'package:orbit/models/broswer.dart';
import 'package:orbit/models/folder.dart';
import 'package:orbit/models/space.dart';
import 'package:orbit/models/tab.dart';
import 'package:orbit/models/space_item_tree_node.dart';

class SpaceTreeController extends GetxController {
  late final TreeController<SpaceItemTreeNode> treeController;
  late final Broswer broswer;
  final int spaceIndex;

  SpaceTreeController({required this.spaceIndex});

  @override
  void onInit() {
    super.onInit();
    broswer = Get.find<Broswer>();
    var space = broswer.spaces[spaceIndex] as Space;

    treeController = TreeController<SpaceItemTreeNode>(
      roots: broswer.spaces[spaceIndex].children,
      childrenProvider: (node) => node.children,
      parentProvider: (node) => node.parent,
    );
    space.treeController = treeController;
  }

  void populateExampleTree(SpaceItemTreeNode node, [int level = 0]) {
    if (level >= 3) return;

    for (int index = 0; index <= 3; ++index) {
      SpaceItemTreeNode child;
      if (level == 0) {
        child = Folder(name: 'Folder $index');
      } else {
        child = TabNode(name: 'Tab $index', url: 'http://example.com');
      }
      node.insertChild(node.children.length, child);
      populateExampleTree(child, level + 1);
    }
  }

  void onNodeAccepted(TreeDragAndDropDetails<SpaceItemTreeNode> details) {
    SpaceItemTreeNode? newParent;
    int newIndex = 0;

    details.mapDropPosition(
      whenAbove: () {
        newParent = details.targetNode.parent;
        newIndex = details.targetNode.index;
      },
      whenInside: () {
        if (details.targetNode is Folder || details.targetNode is Space) {
          newParent = details.targetNode;
          newIndex = details.targetNode.children.length;
          treeController.setExpansionState(details.targetNode, true);
        } else {
          newParent = details.draggedNode.parent;
          newIndex = details.draggedNode.index;
        }
      },
      whenBelow: () {
        newParent = details.targetNode.parent;
        newIndex = details.targetNode.index + 1;
      },
    );

    // if (details.targetNode is! Folder) return;
    (newParent ?? broswer.spaces[spaceIndex])
        .insertChild(newIndex, details.draggedNode);

    treeController.rebuild();
  }
}

extension on TreeDragAndDropDetails<SpaceItemTreeNode> {
  T mapDropPosition<T>({
    required T Function() whenAbove,
    required T Function() whenInside,
    required T Function() whenBelow,
  }) {
    final double oneThirdOfTotalHeight = targetBounds.height * 0.3;
    final double pointerVerticalOffset = dropPosition.dy;

    if (pointerVerticalOffset < oneThirdOfTotalHeight) {
      return whenAbove();
    } else if (pointerVerticalOffset < oneThirdOfTotalHeight * 2) {
      return whenInside();
    } else {
      return whenBelow();
    }
  }
}

class SpaceTreeView extends StatelessWidget {
  final int spaceIndex;

  const SpaceTreeView({super.key, required this.spaceIndex});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpaceTreeController>(
      init: SpaceTreeController(spaceIndex: spaceIndex),
      tag: spaceIndex.toString(),
      builder: (controller) {
        return Column(
          children: [
            Row(children: [
              Text(
                '  Space ${controller.broswer.spaces[spaceIndex].name}',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  // fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
            Expanded(
              child: AnimatedTreeView<SpaceItemTreeNode>(
                padding: const EdgeInsets.all(0),
                treeController: controller.treeController,
                nodeBuilder: (context, entry) {
                  return DragAndDropTreeTile(
                    entry: entry,
                    onNodeAccepted: (details) {
                      controller.onNodeAccepted(details);
                    },
                    onFolderPressed: () =>
                        controller.treeController.toggleExpansion(entry.node),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class DragAndDropTreeTile extends StatelessWidget {
  final TreeEntry<SpaceItemTreeNode> entry;
  final TreeDragTargetNodeAccepted<SpaceItemTreeNode> onNodeAccepted;
  final VoidCallback? onFolderPressed;

  const DragAndDropTreeTile({
    super.key,
    required this.entry,
    required this.onNodeAccepted,
    this.onFolderPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TreeDragTarget<SpaceItemTreeNode>(
      node: entry.node,
      onNodeAccepted: onNodeAccepted,
      builder: (context, details) {
        Decoration? decoration;

        if (details != null) {
          decoration = BoxDecoration(
            border: details.mapDropPosition(
              whenAbove: () =>
                  const Border(top: BorderSide(color: Colors.blue, width: 2.0)),
              whenInside: () {
                if (details.targetNode is Folder ||
                    details.targetNode is Space) {
                  return Border.all(color: Colors.blue, width: 2.0);
                } else {
                  return null;
                }
              },
              whenBelow: () => const Border(
                  bottom: BorderSide(color: Colors.blue, width: 2.0)),
            ),
          );
        }

        return TreeDraggable<SpaceItemTreeNode>(
          node: entry.node,
          childWhenDragging: Opacity(
            opacity: .5,
            child: IgnorePointer(
              child: TreeTile(entry: entry),
            ),
          ),
          feedback: IntrinsicWidth(
            child: Material(
              elevation: 4,
              child: TreeTile(
                entry: entry,
                showIndentation: false,
                onFolderPressed: () {},
              ),
            ),
          ),
          child: TreeTile(
            entry: entry,
            onFolderPressed:
                entry.node.children.isEmpty ? null : onFolderPressed,
            decoration: decoration,
          ),
        );
      },
    );
  }
}

class TreeTile extends StatelessWidget {
  final TreeEntry<SpaceItemTreeNode> entry;
  final VoidCallback? onFolderPressed;
  final Decoration? decoration;
  final bool showIndentation;

  const TreeTile({
    super.key,
    required this.entry,
    this.onFolderPressed,
    this.decoration,
    this.showIndentation = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            if (entry.node is Folder)
              IconButton(
                icon: Icon(!entry.isExpanded || entry.node.children.isEmpty
                    ? Icons.folder
                    : Icons.folder_open),
                onPressed: onFolderPressed,
              )
            else
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.insert_drive_file),
              ),
            Expanded(
              child: Text(entry.node.name),
            ),
          ],
        ),
      ),
    );

    if (decoration != null) {
      content = DecoratedBox(
        decoration: decoration!,
        child: content,
      );
    }

    if (showIndentation) {
      return TreeIndentation(
        entry: entry,
        guide: const IndentGuide(
          indent: 20,
        ),
        child: content,
      );
    }

    return content;
  }
}
