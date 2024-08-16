import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterWidget extends StatelessWidget {
  final Function(String) onFilterSelected;

  const FilterWidget({Key? key, required this.onFilterSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: SvgPicture.asset(
        "assets/svg/filter.svg",
        height: 20,
        width: 20,
        // ignore: deprecated_member_use
        color: Colors.yellow,
      ),
      onSelected: (String value) {
        onFilterSelected(value);
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'Recipes',
            child: Text('Recipes'),
          ),
          PopupMenuItem(
            value: 'Chefs',
            child: Text('Chefs'),
          ),
          PopupMenuItem(
            value: 'Tags',
            child: Text('Tags'),
          ),
        ];
      },
    );
  }
}
