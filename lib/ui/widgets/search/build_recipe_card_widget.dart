import 'package:flutter/material.dart';
import 'package:retsept_cherno/data/models/retsept_model.dart';
import 'package:retsept_cherno/ui/widgets/home/recipe_card.dart';

class BuildRecipeCardWidget extends StatelessWidget {
  const BuildRecipeCardWidget({super.key, required this.retsept});
  final RetseptModel retsept;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              retsept.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: 8.0,
            left: 8.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 12.0),
                  const SizedBox(width: 4.0),
                  Text(
                    retsept.rate.toString(),
                    style: const TextStyle(
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
              child: Text(
                retsept.name,
                style: const TextStyle(
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
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => RecipeCard(retsept: retsept)));
      },
    );
  }
}
