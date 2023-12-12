import 'package:flutter/material.dart';
import 'package:shopping_list/src/components/grocery_item.dart';
import 'package:shopping_list/src/data/dummy_items.dart';
import 'package:shopping_list/src/screen/new_item_screen.dart';

class GroceryListScreens extends StatefulWidget {
  @override
  State<GroceryListScreens> createState() => _GroceryListScreensState();
}

class _GroceryListScreensState extends State<GroceryListScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => NewItemScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (ctx, idx) {
            final item = groceryItems[idx];
            return GroceryItems(
              grocery: item,
            );
          }),
    );
  }
}
