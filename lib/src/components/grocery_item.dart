import 'package:flutter/material.dart';
import 'package:shopping_list/src/components/colored_box.dart';
import 'package:shopping_list/src/models/groccery_items.dart';

class GroceryItems extends StatelessWidget {
  const GroceryItems({super.key, required this.grocery});
  final GroceryItem grocery;
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: ValueKey(grocery.id),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          TColoredBox(
            color: grocery.category.color,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            grocery.name,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
          ),
          const Spacer(),
          Text(
            grocery.quantity.toString(),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
