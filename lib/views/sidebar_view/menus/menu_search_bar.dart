import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/models/broswer.dart';

class MenuSearchBar extends StatelessWidget {
  const MenuSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    var broswer = Get.find<Broswer>();
    return GestureDetector(
      onTap: () {
        // Add your code here for when the box is clicked
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            String userInput = '';
            String url = '';
            return AlertDialog(
              title: const Text('Create New Tab'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    onChanged: (value) => userInput = value,
                    decoration: const InputDecoration(
                        hintText: "Search or Enter URL..."),
                  ),
                ],
              ),
              actions: <Widget>[
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
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: SizedBox(
                    child: Text(
                      'Search or enter url...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.theme.colorScheme.onSurface
                            .withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.display_settings_outlined),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
