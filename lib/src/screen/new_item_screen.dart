import 'package:flutter/material.dart';

class NewItemScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
            child: Column(
          children: [_TextFormField()],
        )),
      ),
    );
  }
}

class _TextFormField extends StatelessWidget {
  const _TextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 50,
      decoration: InputDecoration(
          label: Text(
            'Name',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Theme.of(context).colorScheme.secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Theme.of(context).colorScheme.secondary),
          )),
      validator: (value) {
        return null;
      },
    );
  }
}
