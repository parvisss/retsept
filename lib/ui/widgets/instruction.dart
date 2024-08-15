import 'package:flutter/material.dart';
import 'package:retsept_cherno/ui/screens/tadbox_screen.dart';
import 'package:retsept_cherno/ui/widgets/recipe_screen.dart';

class InstructionsScreen extends StatefulWidget {
  const InstructionsScreen({super.key});

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  final List<String> instructions = [
    'In a large bowl, mix together flour, baking powder, sugar, and salt.',
    'In a separate bowl, whisk together milk, egg, and oil or melted butter. Add vanilla extract if desired.',
    'Gradually add the liquid mixture to the dry ingredients, stirring continuously until a smooth, lump-free batter forms.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Recipe'),
        centerTitle: true,
        backgroundColor: const Color(0xff4058A0),
        actions: [
          TextButton(
            onPressed: () {
              // Clear all instructions
            },
            child: const Text(
              "Clear all",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const StepperWidget(activeStep: 2),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: instructions.length,
                itemBuilder: (context, index) {
                  return InstructionCard(
                    index: index,
                    instruction: instructions[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecipeScreen(),
                  ),
                );
              },
              child: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
     
    );
  }
}
