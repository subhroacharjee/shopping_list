import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/src/components/colored_box.dart';
import 'package:shopping_list/src/data/categories_data.dart';
import 'package:shopping_list/src/models/category.dart';
import 'package:shopping_list/src/models/groccery_items.dart';

class NewItemScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _formKey = GlobalKey<FormState>();

  void _saveItem() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    final url = Uri.https("flutter-prep-c3220-default-rtdb.asia-southeast1.firebasedatabase.app",
        "shopping_list.json");
    final respone = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "name": _name,
          "quantity": _quantity,
          "category": _selectedCategory.name,
        }));

    if (respone.statusCode == 200) {
      Map<String, dynamic> body = const JsonDecoder().convert(respone.body);
      if (!body.containsKey("name")) {
        print(body);
        return;
      }
      final newGrocery = GroceryItem(
        id: "${body["name"]}",
        name: _name,
        quantity: _quantity,
        category: _selectedCategory,
      );

      if (context.mounted) Navigator.of(context).pop(newGrocery);
    }
  }

  var _name = '';
  var _quantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _TextFormField(
                "Name",
                (val) => val.trim().length <= 1 || val.trim().length > 50,
                onSave: (value) => _name = value!,
              ),
              _TextFormField(
                "Quantity",
                (val) => int.tryParse(val) == null || int.tryParse(val)! <= 0,
                isSring: false,
                onSave: (value) => _quantity = int.parse(value!),
              ),
              DropdownButtonFormField(
                value: _selectedCategory,
                items: [
                  for (final category in categories.entries)
                    DropdownMenuItem(
                      value: category.value,
                      onTap: () {},
                      child: Row(children: [
                        TColoredBox(
                          color: category.value.color,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          category.value.name,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ]),
                    )
                ],
                onChanged: (obj) {
                  setState(() {
                    _selectedCategory = obj!;
                  });
                },
                decoration: InputDecoration(
                  label: Text(
                    "Category",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 3, color: Theme.of(context).colorScheme.secondary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 3, color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => _formKey.currentState!.reset(),
                    child: const Text("Reset"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: Text("Add item"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TextFormField extends StatelessWidget {
  const _TextFormField(
    this.value,
    this.validate, {
    super.key,
    this.isSring = true,
    required this.onSave,
  });
  final String value;
  final bool Function(String) validate;
  final bool isSring;
  final void Function(String?) onSave;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 50,
      keyboardType: isSring ? TextInputType.text : TextInputType.number,
      onSaved: onSave,
      decoration: InputDecoration(
        label: Text(
          this.value,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Theme.of(context).colorScheme.secondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty || validate(value)) return 'Invalid input';
        return null;
      },
    );
  }
}
