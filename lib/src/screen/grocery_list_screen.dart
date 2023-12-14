import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_list/src/components/grocery_item.dart';
import 'package:shopping_list/src/data/categories_data.dart';
import 'package:shopping_list/src/models/groccery_items.dart';
import 'package:shopping_list/src/screen/new_item_screen.dart';

class GroceryListScreens extends StatefulWidget {
  @override
  State<GroceryListScreens> createState() => _GroceryListScreensState();
}

class _GroceryListScreensState extends State<GroceryListScreens> {
  List<GroceryItem> groceryItems = [];

  @override
  void initState() {
    super.initState();
    final url = Uri.https("flutter-prep-c3220-default-rtdb.asia-southeast1.firebasedatabase.app",
        "shopping_list.json");
    http.get(url, headers: {
      'Content-Type': 'application/json',
    }).then((response) {
      Map<String, dynamic> body = const JsonDecoder().convert(response.body);
      for (final entry in body.entries) {
        setState(() {
          groceryItems.add(GroceryItem(
              id: entry.key,
              name: entry.value["name"],
              quantity: entry.value["quantity"],
              category: categories.entries
                  .firstWhere((catItem) => catItem.value.name == entry.value["category"])
                  .value));
        });
      }
    }).catchError((err) {
      print("Error: $err");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () async {
              final newItem = await Navigator.of(context).push<GroceryItem>(
                MaterialPageRoute(
                  builder: (ctx) => NewItemScreen(),
                ),
              );

              setState(() {
                groceryItems.add(newItem!);
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: groceryItems.isEmpty
          ? Center(
              child: Text(
                "No Items yet",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            )
          : ListView.builder(
              itemCount: groceryItems.length,
              itemBuilder: (ctx, idx) {
                final item = groceryItems[idx];
                return GroceryItems(
                  grocery: item,
                  onDismissed: () {
                    setState(() {
                      groceryItems.remove(groceryItems[idx]);
                    });
                  },
                );
              }),
    );
  }
}
