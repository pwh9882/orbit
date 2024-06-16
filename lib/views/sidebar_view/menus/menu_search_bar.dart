import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/models/broswer.dart';

class MenuSearchBar extends StatelessWidget {
  const MenuSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    var browser = Get.find<Broswer>();

    return Obx(
      () => GestureDetector(
        onTap: () {
          // Add your code here for when the box is clicked
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              String userInput = '';
              return AlertDialog(
                content: SizedBox(
                  width: 600,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(
                              text: browser.webviewTabViewerController
                                  .currentTabUrl.value),
                          onChanged: (value) => userInput = value,
                          decoration: const InputDecoration(
                            hintText: "Search or Enter URL...",
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_rounded),
                        onPressed: () {
                          Get.back(); // Close the dialog
                          if (userInput.isNotEmpty) {
                            if (browser.webviewTabViewerController
                                    .currentTabIndex.value ==
                                -1) {
                              browser.createTabToCurrentSpace(userInput);
                            } else {
                              browser.loadUrlToCurrentTab(userInput);
                            }
                          }
                        },
                      ),
                    ],
                  ),
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
        child: SizedBox(
          height: 50,
          child: Card(
            color: context.theme.colorScheme.shadow.withOpacity(0.01),
            child: Row(
              children: [
                if (browser.webviewTabViewerController.currentTabIndex.value ==
                    -1)
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: SizedBox(
                      child: Text(
                        browser.webviewTabViewerController.currentTabUrlHost
                                    .value ==
                                ''
                            ? 'Search or Enter URL...'
                            : browser.webviewTabViewerController
                                .currentTabUrlHost.value,
                        // 'Search or enter url...',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.theme.colorScheme.onSurface
                              .withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                ),
                if (browser.webviewTabViewerController.currentTabIndex.value !=
                    -1)
                  IconButton(
                    icon: const Icon(Icons.display_settings_outlined),
                    onPressed: () {},
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
