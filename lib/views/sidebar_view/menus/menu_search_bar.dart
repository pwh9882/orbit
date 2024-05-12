import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuSearchBar extends StatelessWidget {
  const MenuSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Card(
        color: context.theme.colorScheme.onSurface.withOpacity(0.1),
        child: SizedBox(
          height: 38,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          hintText: 'Search or enter url...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: context.theme.colorScheme.onSurface.withOpacity(0.15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
