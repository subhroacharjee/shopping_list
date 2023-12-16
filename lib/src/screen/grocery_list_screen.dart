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
  var _isLoading = true;
  List<GroceryItem> groceryItems = [];

  @override
  void initState() {
    super.initState();
    final url = Uri.https("flutter-prep-c3220-default-rtdb.asia-southeast1.firebasedatabase.app",
        "shopping_list.json");
    http.get(url, headers: {
      'Content-Type': 'application/json',
    }).then((response) {
      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }
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
          _isLoading = false;
        });
      }
    }).catchError((err) {
      setState(() {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Something went wrong please try again!"),
          ),
        );
      });
      print("Error: $err");
    });
  }

  void _removeItem(GroceryItem item, int idx) {
    setState(() {
      groceryItems.remove(groceryItems[idx]);
    });

    final url = Uri.https("flutter-prep-c3220-default-rtdb.asia-southeast1.firebasedatabase.app",
        "shopping_list/${item.id}.json");
    http.delete(url).catchError((err) {
      print("Err:$err");
      setState(() {
        groceryItems.insert(idx, item);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Unable to delete at this moment."),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = groceryItems.isEmpty
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
                  _removeItem(item, idx);
                },
              );
            });
    if (_isLoading) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    }

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
      body: content,
    );
  }
}
