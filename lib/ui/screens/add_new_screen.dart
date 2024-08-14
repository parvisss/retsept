import 'package:flutter/material.dart';
import 'package:retsept_cherno/ui/widgets/ingredients.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  int _serving = 4;
  int _selectedDifficulty = 0;
  final List<String> _selectedDishTypes = [];
  final List<String> _selectedDietaryTargets = [];
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 3) {
      setState(
        () {
          _currentStep++;
        },
      );

      // Navigate to the Ingredients page when moving to step 2
      if (_currentStep == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Ingredients()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Recipe",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Clear all",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xff4058A0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              EasyStepper(
                activeStep: _currentStep,
                steps: const [
                  EasyStep(
                    title: "Recipe Information",
                    icon: Icon(
                      Icons.receipt,
                    ),
                  ),
                  EasyStep(
                    title: "Ingredients",
                    icon: Icon(
                      Icons.info,
                    ),
                  ),
                  EasyStep(
                    title: "Introduction",
                    icon: Icon(
                      Icons.list,
                    ),
                  ),
                  EasyStep(
                    title: "Summary",
                    icon: Icon(
                      Icons.check_circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                child: buildSectionTitle("Name"),
              ),
              const SizedBox(height: 5),
              buildTextField("Name your recipe"),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                child: buildSectionTitle("Number"),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Serving for"),
                  const SizedBox(height: 16),
                  buildNumberSelector(),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                child: buildSectionTitle("Cook Time"),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  buildTimeField("h"),
                  const SizedBox(width: 10),
                  buildTimeField("m"),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                child: buildSectionTitle("Difficulty"),
              ),
              const SizedBox(height: 10),
              buildDifficultySelector(),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                child: buildSectionTitle("Dish Type"),
              ),
              const SizedBox(height: 8),
              buildChipSelector(
                [
                  'Breakfast',
                  'Lunch',
                  'Snack',
                  'Brunch',
                  'Dessert',
                  'Dinner',
                  'Appetizers'
                ],
                _selectedDishTypes,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                child: buildSectionTitle("Hashtags"),
              ),
              buildTextField("#egg #Vegan #Sugarfree #lowfat"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _nextStep,
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
      ),

    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

      body: const Column(
        children: [],

      ),
    );
  }

  Widget buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget buildNumberSelector() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (_serving > 1) _serving--;
            });
          },
        ),
        Text('$_serving'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              _serving++;
            });
          },
        ),
      ],
    );
  }

  Widget buildTimeField(String label) {
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

  Widget buildDifficultySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ['Easy', 'Medium', 'Hard'].asMap().entries.map((entry) {
        int index = entry.key;
        String difficulty = entry.value;
        return ChoiceChip(
          label: Text(difficulty),
          selected: _selectedDifficulty == index,
          onSelected: (selected) {
            setState(() {
              _selectedDifficulty = index;
            });
          },
        );
      }).toList(),
    );
  }

  Widget buildChipSelector(List<String> options, List<String> selectedOptions) {
    return Wrap(
      spacing: 8.0,
      children: options.map((option) {
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
