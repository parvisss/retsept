import 'package:flutter/material.dart';
import 'package:retsept_cherno/ui/widgets/latest_recipe_card.dart';
import 'package:retsept_cherno/ui/widgets/recept_widget.dart';

class SilverFillReaminingWidget extends StatefulWidget {
  const SilverFillReaminingWidget({super.key});

  @override
  State<SilverFillReaminingWidget> createState() =>
      _SilverFillReaminingWidgetState();
}

class _SilverFillReaminingWidgetState extends State<SilverFillReaminingWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: TabBarView(
        children: [
          GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: 6, // 6 images
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) {
              return Image.asset(
                'assets/food${(index % 6) + 2}.png',
                fit: BoxFit.cover,
              );
            },
          ),
          const ReceptWidget(),
          const LatestRecipeCard(),
        ],
      ),
    );
  }
}
