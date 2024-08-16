import 'package:flutter/material.dart';
import 'package:retsept_cherno/data/models/retsept_model.dart';
import 'package:retsept_cherno/ui/widgets/search/build_recipe_card_widget.dart';

class BuildGridViewWidget extends StatelessWidget {
  final String searchQuery;
  final List<RetseptModel> retsepts;

  const BuildGridViewWidget({
    super.key,
    required this.searchQuery,
    required this.retsepts,
  });

  @override
  Widget build(BuildContext context) {
    // Filter the retsepts based on the search query
    List<RetseptModel> filteredRetsepts = retsepts.where((retsept) {
      // Assuming the RetseptModel has a 'title' property to match the search query
      return retsept.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: filteredRetsepts.length,
      itemBuilder: (context, index) {
        RetseptModel retsept = filteredRetsepts[index];
        return BuildRecipeCardWidget(
          retseptId: retsept.id,
        );
      },
    );
  }
}
