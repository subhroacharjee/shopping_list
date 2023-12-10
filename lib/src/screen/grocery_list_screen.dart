import 'package:flutter/material.dart';
import 'package:shopping_list/src/components/grocery_item.dart';
import 'package:shopping_list/src/data/dummy_items.dart';

class GroceryListScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
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
