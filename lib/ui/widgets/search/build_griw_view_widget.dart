import 'package:flutter/material.dart';
import 'package:retsept_cherno/data/models/retsept_model.dart';
import 'package:retsept_cherno/ui/widgets/search/build_recipe_card_widget.dart';

class BuildGridViewWidget extends StatelessWidget {
  final String searchQuery;
  final List retsepts;

  BuildGridViewWidget(
      {super.key, required this.searchQuery, required this.retsepts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: retsepts.length,
      itemBuilder: (context, index) {
        RetseptModel retsept = RetseptModel.fromJson(retsepts[index]);
        return BuildRecipeCardWidget(
          retseptId: retsept.id,
        );
      },
    );
  }
}
