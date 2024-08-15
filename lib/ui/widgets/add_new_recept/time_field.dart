import 'package:flutter/material.dart';

class TimeField extends StatelessWidget {
  final String label;

  const TimeField({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          hintText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
