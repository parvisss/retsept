import 'package:flutter/material.dart';

class BuildTagListWidget extends StatelessWidget {
  final String searchQuery;

  BuildTagListWidget({super.key, required this.searchQuery, required String filterSelection});

  final List<String> tags = [
    '#egg',
    '#eggrecipe',
    '#eggfast',
    '#eggsandwich',
    '#eggrolls',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredTags = tags.where((tag) {
      return tag.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: filteredTags.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.tag),
          ),
          title: Text(filteredTags[index]),
        );
      },
    );
  }
}
