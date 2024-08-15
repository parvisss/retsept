import 'package:flutter/material.dart';
import 'package:retsept_cherno/ui/screens/tab_box_screen.dart';

import 'package:retsept_cherno/ui/widgets/add_new_recept/instruction.dart';
import 'package:retsept_cherno/ui/widgets/add_new_recept/recipe_screen.dart';

class Ingredients extends StatefulWidget {
  const Ingredients({super.key});

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  final List<String> ingredients = [
    '2 cups all-purpose flour',
    '2 teaspoons baking powder',
    '2 tablespoons sugar',
    '1/2 teaspoon salt',
    '1.5 cups milk',
    '1 large egg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingredients'),
        centerTitle: true,
        backgroundColor: const Color(0xff4058A0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const StepperWidget(activeStep: 1),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text(
                          '${index + 1}'.padLeft(2, '0'),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(ingredients[index]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InstructionsScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 40),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    
        );
  }
}
