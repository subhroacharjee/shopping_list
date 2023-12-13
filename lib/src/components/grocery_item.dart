import 'package:flutter/material.dart';
import 'package:shopping_list/src/components/colored_box.dart';
import 'package:shopping_list/src/models/groccery_items.dart';

class GroceryItems extends StatelessWidget {
  const GroceryItems({
    super.key,
    required this.grocery,
    required this.onDismissed,
  });
  final void Function() onDismissed;
  final GroceryItem grocery;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(grocery.id),
      onDismissed: (direction) => onDismissed(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete),
      ),
      child: ListTile(
        leading: TColoredBox(color: grocery.category.color),
        title: Text(
          grocery.name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
        trailing: Text(
          grocery.quantity.toString(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white60,
              ),
        ),
      ),
    );
  }
}
