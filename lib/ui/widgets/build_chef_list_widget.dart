import 'package:flutter/material.dart';

class BuildChefListWidget extends StatelessWidget {
  final String searchQuery;

  BuildChefListWidget({super.key, required this.searchQuery});

  final List<Map<String, String>> chefs = [
    {'name': 'Mark Salvador', 'image': 'assets/chef3.png'},
    {'name': 'Martin Robert', 'image': 'assets/chef2.png'},
    {'name': 'Melisa Anne', 'image': 'assets/chef2.png'},
    {'name': 'Dave Robert', 'image': 'assets/chef.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredChefs = chefs.where((chef) {
      return chef['name']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: filteredChefs.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(filteredChefs[index]['image']!),
          ),
          title: Text(filteredChefs[index]['name']!),
        );
      },
    );
  }
}
