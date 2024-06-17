import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:orbit/models/broswer.dart';
import 'package:orbit/views/sidebar_view/menus/menu_space_page_indicator/reorderable_smooth_page_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MenuSpacePageIndicator extends StatelessWidget {
  MenuSpacePageIndicator({
    super.key,
    required this.pageviewController,
  });
  final broswer = Get.find<Broswer>();
  final PageController pageviewController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            // history
            onPressed: () {
              // TODO: implement onPressed
            },
            icon: Icon(
              Icons.history_outlined,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
          Obx(
            () => ReorderableSmoothPageIndicator(
              controller: pageviewController,
              count: broswer.spaces.length,
              effect: ScrollingDotsEffect(
                activeDotColor:
                    Theme.of(context).colorScheme.onSecondaryContainer,
                dotColor: Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer
                    .withOpacity(0.5),
                dotHeight: 15.0,
                dotWidth: 15.0,
                spacing: 12.0,
              ),
              onDotClicked: (index) => pageviewController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              ),
            ),
          ),
          PopupMenuButton<SampleItem>(
            icon: Icon(
              Icons.add_circle_outline,
              color: context.theme.colorScheme.onBackground,
            ),
            // initialValue: controller.selectedItem.value,
            onSelected: (SampleItem item) {
              // controller.updateSelectedItem(item);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemOne,
                child: const Text('Create New Space'),
                onTap: () {
                  showDialog(
                    context: Get.context!,
                    builder: (BuildContext context) {
                      String spaceName = '';
                      return AlertDialog(
                        // title: const Text('Create New Space'),
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                onChanged: (value) => spaceName = value,
                                decoration: const InputDecoration(
                                    hintText: "Space Name"),
                              ),
                            ),
                            TextButton(
                              child: const Text('Create'),
                              onPressed: () {
                                Get.back(); // Close the dialog
                                if (spaceName.isNotEmpty) {
                                  broswer.createSpace(spaceName);
                                }
                              },
                            ),
                          ],
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 20,
                          right: 0,
                          top: 10,
                          bottom: 10,
                        ),
                      );
                    },
                  );
                },
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemTwo,
                child: const Text('Create New Folder'),
                onTap: () => {
                  showDialog(
                    context: Get.context!,
                    builder: (BuildContext context) {
                      String folderName = '';
                      return AlertDialog(
                        // title: const Text('Create New Folder'),
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                onChanged: (value) => folderName = value,
                                decoration: const InputDecoration(
                                  hintText: "Folder Name",
                                ),
                              ),
                            ),
                            TextButton(
                              child: const Text('Create'),
                              onPressed: () {
                                Get.back(); // Close the dialog
                                if (folderName.isNotEmpty) {
                                  broswer
                                      .createFolderToCurrentSpace(folderName);
                                }
                              },
                            ),
                          ],
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 20,
                          right: 0,
                          top: 10,
                          bottom: 10,
                        ),
                      );
                    },
                  )
                },
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemThree,
                child: const Text('Create New Tab'),
                onTap: () {
                  showDialog(
                    context: Get.context!,
                    builder: (BuildContext context) {
                      String userInput = '';
                      return AlertDialog(
                        // title: const Text('Create New Tab'),
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                onChanged: (value) => userInput = value,
                                decoration: const InputDecoration(
                                    hintText: "Search or Enter URL..."),
                              ),
                            ),
                            TextButton(
                              child: const Text('Create'),
                              onPressed: () {
                                Get.back(); // Close the dialog
                                if (userInput.isNotEmpty) {
                                  broswer.createTabToCurrentSpace(userInput);
                                }
                              },
                            ),
                          ],
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 20,
                          right: 0,
                          top: 10,
                          bottom: 10,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
            offset: const Offset(-120, -165), // 팝업 메뉴의 위치를 위로 조정
            elevation: 4.0, // 팝업 메뉴에 그림자 효과를 추가
          ),
        ],
      ),
    );
  }
}

enum SampleItem { itemZero, itemOne, itemTwo, itemThree }
