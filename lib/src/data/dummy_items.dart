import 'package:shopping_list/src/data/categories_data.dart';
import 'package:shopping_list/src/models/category.dart';
import 'package:shopping_list/src/models/groccery_items.dart';

var groceryItems = [
  GroceryItem(id: 'a', name: 'Milk', quantity: 1, category: categories[Categories.dairy]!),
  GroceryItem(id: 'b', name: 'Bananas', quantity: 5, category: categories[Categories.fruit]!),
  GroceryItem(id: 'c', name: 'Beef Steak', quantity: 1, category: categories[Categories.meat]!),
];
