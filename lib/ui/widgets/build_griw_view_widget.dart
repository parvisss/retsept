import 'package:flutter/material.dart';
import 'package:retsept_cherno/ui/widgets/build_recipe_card_widget.dart';

class BuildGridViewWidget extends StatelessWidget {
  final String searchQuery;

  BuildGridViewWidget({super.key, required this.searchQuery});

  final List<String> imagePaths = [
    'assets/food8.png',
    'assets/food2.png',
    'assets/food3.png',
    'assets/food4.png',
    'assets/food5.png',
    'assets/food6.png',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredImages = imagePaths.where((imagePath) {
      final imageName = imagePath.split('/').last.toLowerCase();
      return imageName.contains(searchQuery.toLowerCase());
    }).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: filteredImages.length,
      itemBuilder: (context, index) {
        return BuildRecipeCardWidget(
            imagePath: filteredImages[index]); // Fixed imagePath parameter
      },
    );
  }
}
