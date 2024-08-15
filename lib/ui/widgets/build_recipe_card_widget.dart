import 'package:flutter/material.dart';

class BuildRecipeCardWidget extends StatelessWidget {
  final String imagePath;

  const BuildRecipeCardWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 8.0,
          left: 8.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.7),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 12.0),
                SizedBox(width: 4.0),
                Text(
                  '4.8',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Container(
            padding: const EdgeInsets.all(4.0),
            color: Colors.black54,
            child: const Text(
              'Chocolate Cake with Buttercream Frosting',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
