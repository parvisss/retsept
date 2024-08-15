import 'package:flutter/material.dart';

class BuildChipSelectorWidget extends StatefulWidget {
  const BuildChipSelectorWidget({super.key, required this.options, required List<String> selectedOptions, required Null Function(dynamic selectedOptions) onSelectionChanged});

  final List<String> options;

  @override
  State<BuildChipSelectorWidget> createState() =>
      _BuildChipSelectorWidgetState();
}

class _BuildChipSelectorWidgetState extends State<BuildChipSelectorWidget> {
  late List<String> selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = [];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: widget.options.map((option) {
        return FilterChip(
          label: Text(option),
          selected: selectedOptions.contains(option),
          onSelected: (selected) {
            setState(() {
              selected
                  ? selectedOptions.add(option)
                  : selectedOptions.remove(option);
            });
          },
        );
      }).toList(),
    );
  }
}
