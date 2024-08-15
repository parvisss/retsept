import 'package:flutter/material.dart';

class DifficultySelector extends StatelessWidget {
  final int selectedDifficulty;
  final ValueChanged<int> onDifficultyChanged;

  const DifficultySelector({required this.selectedDifficulty, required this.onDifficultyChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ['Easy', 'Medium', 'Hard'].asMap().entries.map((entry) {
        int index = entry.key;
        String difficulty = entry.value;
        return ChoiceChip(
          label: Text(difficulty),
          selected: selectedDifficulty == index,
          onSelected: (selected) {
            onDifficultyChanged(index);
          },
        );
      }).toList(),
    );
  }
}
