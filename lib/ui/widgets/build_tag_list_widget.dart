import 'package:flutter/material.dart';

class BuildTagListWidget extends StatelessWidget {
  BuildTagListWidget({super.key});

  final List<String> tags = [
    '#egg',
    '#eggrecipe',
    '#eggfast',
    '#eggsandwich',
    '#eggrolls',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: tags.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.tag),
          ),
          title: Text(tags[index]),
        );
      },
    );
  }
}
