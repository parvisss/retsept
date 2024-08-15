import 'package:flutter/material.dart';

class BuildChefListWidget extends StatelessWidget {
  const BuildChefListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> chefs = [
      {'name': 'Mark Salvador', 'image': 'assets/chef3.png'},
      {'name': 'Martin Robert', 'image': 'assets/chef2.png'},
      {'name': 'Melisa Anne', 'image': 'assets/chef2.png'},
      {'name': 'Dave Robert', 'image': 'assets/chef.png'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: chefs.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(chefs[index]['image']!),
          ),
          title: Text(chefs[index]['name']!),
        );
      },
    );
  }
}
