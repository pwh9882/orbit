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
    if (entry.node is TabNode) {
      broswer.closeTab((entry.node as TabNode));
    }
    treeController.rebuild();
  }

  void onNodeClosePressed(TreeEntry<SpaceItemTreeNode> entry) {
    broswer.closeTab((entry.node as TabNode));
    treeController.rebuild();
  }

  void onEditNode(TreeEntry<SpaceItemTreeNode> entry) {}

  void onNodeSelected(TreeEntry<SpaceItemTreeNode> entry) {
    broswer.selectTab(entry.node as TabNode);
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
            GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Manage Space'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text('Edit'),
                            onTap: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  String userInput = '';
                                  return AlertDialog(
                                    title: const Text('Edit Space Name'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        TextField(
                                          controller: TextEditingController()
                                            ..text = controller.broswer
                                                .spaces[spaceIndex].name,
                                          onChanged: (value) =>
                                              userInput = value,
                                          decoration: const InputDecoration(
                                            labelText: "Name",
                                          ),
                                        ),
                                        // TextField(
                                        //   onChanged: (value) => url = value,
                                        //   decoration: const InputDecoration(
                                        //     hintText: "URL",
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Save'),
                                        onPressed: () {
                                          Get.back(); // Close the dialog
                                          if (userInput.isNotEmpty) {
                                            controller.broswer
                                                .renameSpace(userInput);
                                            controller.update();
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text('Delete Space'),
                            onTap: () {
                              Navigator.pop(context);
                              controller.broswer.deleteCurrentSpace();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Row(children: [
                Text(
                  '   ${controller.broswer.spaces[spaceIndex].name}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),
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
                    onNodeNameRenamed: () {
                      entry.node.updateNodeName(entry.node.name);
                      controller.treeController.rebuild();
                    },
                    onNodeClosePressed: () {
                      controller.onNodeClosePressed(entry);
                    },
                    onNodeSelected: () {
                      controller.onNodeSelected(entry);
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
  final VoidCallback onNodeNameRenamed;
  final VoidCallback? onNodeClosePressed;
  final VoidCallback onNodeSelected;

  const DragAndDropTreeTile({
    super.key,
    required this.entry,
    required this.onNodeAccepted,
    this.onFolderPressed,
    required this.onNodeDeletePressed,
    required this.onNodeNameRenamed,
    required this.onNodeClosePressed,
    required this.onNodeSelected,
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
                onNodeNameRenamed: onNodeNameRenamed,
                onNodeClosePressed: onNodeClosePressed,
                onNodeSelected: onNodeSelected,
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
                onNodeNameRenamed: onNodeNameRenamed,
                onNodeClosePressed: onNodeClosePressed,
                onNodeSelected: onNodeSelected,
              ),
            ),
          ),
          child: TreeTile(
            entry: entry,
            onFolderPressed:
                entry.node.children.isEmpty ? null : onFolderPressed,
            onNodeDeletePressed: onNodeDeletePressed,
            onNodeNameRenamed: onNodeNameRenamed,
            onNodeClosePressed: onNodeClosePressed,
            onNodeSelected: onNodeSelected,
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
  final VoidCallback onNodeNameRenamed;
  final VoidCallback? onNodeClosePressed;
  final VoidCallback onNodeSelected;
  final Decoration? decoration;
  final bool showIndentation;

  const TreeTile({
    super.key,
    required this.entry,
    this.onFolderPressed,
    required this.onNodeDeletePressed,
    required this.onNodeNameRenamed,
    required this.onNodeClosePressed,
    required this.onNodeSelected,
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
        if (entry.node is TabNode && (entry.node as TabNode).isSeleted)
          if ((entry.node as TabNode).isActivated)
            IconButton(
              onPressed: onNodeClosePressed,
              icon: const Icon(Icons.remove),
            )
          else
            IconButton(
              onPressed: onNodeDeletePressed,
              icon: const Icon(Icons.clear),
            )
      ],
    );

    content = GestureDetector(
      onTap: () {
        // Fluttertoast.showToast(
        //   msg: "Node tapped: ${entry.node.name}",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        // );
        if (entry.node is Folder && onFolderPressed != null) {
          onFolderPressed!();
        }
        if (entry.node is TabNode) {
          onNodeSelected();
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
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String userInput = '';
                          return AlertDialog(
                            title: const Text('Edit Name'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextField(
                                  controller: TextEditingController()
                                    ..text = entry.node.name,
                                  onChanged: (value) => userInput = value,
                                  decoration: const InputDecoration(
                                    labelText: "Name",
                                  ),
                                ),
                                // TextField(
                                //   onChanged: (value) => url = value,
                                //   decoration: const InputDecoration(
                                //     hintText: "URL",
                                //   ),
                                // ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Save'),
                                onPressed: () {
                                  Get.back(); // Close the dialog
                                  if (userInput.isNotEmpty) {
                                    entry.node.name = userInput;
                                    onNodeNameRenamed();
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
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
          color: (entry.node is TabNode &&
                  (entry.node as TabNode).isSeleted &&
                  (entry.node as TabNode).isActivated)
              ? Colors.blue.withOpacity(.2)
              : context.theme.colorScheme.shadow.withOpacity(.2),
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
