import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

    // Restore expansion state for folders
    _restoreExpansionState(space.children);

    space.treeController = treeController;
  }

  void _restoreExpansionState(Iterable<SpaceItemTreeNode> nodes) {
    for (var node in nodes) {
      if (node is Folder && node.isActivated) {
        treeController.setExpansionState(node, true);
      }
      if (node.children.isNotEmpty) {
        _restoreExpansionState(node.children);
      }
    }
    treeController.rebuild();
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
        newIndex = details.targetNode.nodeIndex;
      },
      whenInside: () {
        if (details.targetNode is Folder || details.targetNode is Space) {
          newParent = details.targetNode;
          newIndex = details.targetNode.children.length;
          treeController.setExpansionState(details.targetNode, true);
        } else {
          newParent = details.draggedNode.parent;
          newIndex = details.draggedNode.nodeIndex;
        }
      },
      whenBelow: () {
        newParent = details.targetNode.parent;
        newIndex = details.targetNode.nodeIndex + 1;
      },
    );

    (newParent ?? broswer.spaces[spaceIndex])
        .insertChild(newIndex, details.draggedNode);

    treeController.rebuild();
  }

  void onNodeDeletePressed(TreeEntry<SpaceItemTreeNode> entry) async {
    final parent = entry.node.parent;
    await parent?.removeChild(entry.node);
    treeController.rebuild();
  }

  void onEditNode(TreeEntry<SpaceItemTreeNode> entry) {}
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
                    onFolderPressed: () => {
                      controller.treeController.toggleExpansion(entry.node),
                      if (entry.node is Folder)
                        {
                          (entry.node as Folder).isActivated =
                              !(entry.node as Folder).isActivated,
                        }
                    },
                    onNodeDeletePressed: () {
                      controller.onNodeDeletePressed(entry);
                    },
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
  final VoidCallback onNodeDeletePressed;

  const DragAndDropTreeTile({
    super.key,
    required this.entry,
    required this.onNodeAccepted,
    this.onFolderPressed,
    required this.onNodeDeletePressed,
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
              child: TreeTile(
                entry: entry,
                onNodeDeletePressed: onNodeDeletePressed,
              ),
            ),
          ),
          feedback: IntrinsicWidth(
            child: Material(
              elevation: 4,
              child: TreeTile(
                entry: entry,
                showIndentation: false,
                onFolderPressed: () {},
                onNodeDeletePressed: onNodeDeletePressed,
              ),
            ),
          ),
          child: TreeTile(
            entry: entry,
            onFolderPressed:
                entry.node.children.isEmpty ? null : onFolderPressed,
            onNodeDeletePressed: onNodeDeletePressed,
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
  final VoidCallback onNodeDeletePressed;
  final Decoration? decoration;
  final bool showIndentation;

  const TreeTile({
    super.key,
    required this.entry,
    this.onFolderPressed,
    required this.onNodeDeletePressed,
    this.decoration,
    this.showIndentation = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Row(
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
          child: Text(
            entry.node.name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (entry.node is! Folder)
          IconButton(
            onPressed: onNodeDeletePressed,
            icon: const Icon(Icons.clear),
          )
      ],
    );

    content = GestureDetector(
      onTap: () {
        Fluttertoast.showToast(
          msg: "Node tapped: ${entry.node.name}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        if (entry.node is Folder && onFolderPressed != null) {
          onFolderPressed!();
        }
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Options'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Edit'),
                    onTap: () {
                      // TODO: Implement edit functionality

                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Delete'),
                    onTap: () {
                      Navigator.pop(context);
                      onNodeDeletePressed();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: content,
    );

    // Apply background color and radius
    content = Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
      child: Container(
        decoration: BoxDecoration(
          // color: entry.isSelected
          //     ? Colors.blue.withOpacity(.2)
          //     : Colors.transparent,
          color: context.theme.colorScheme.shadow.withOpacity(.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: content,
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
