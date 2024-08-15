import 'package:flutter/material.dart';

class NumberSelector extends StatelessWidget {
  final int serving;
  final ValueChanged<int> onServingChanged;

  const NumberSelector({required this.serving, required this.onServingChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (serving > 1) onServingChanged(serving - 1);
          },
        ),
        Text('$serving'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            onServingChanged(serving + 1);
          },
        ),
      ],
    );
  }
}
