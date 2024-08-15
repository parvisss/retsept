import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:retsept_cherno/ui/widgets/bottom_navigation_bar.dart';
import 'package:retsept_cherno/ui/widgets/build_chip_selector_widget.dart';
import 'package:retsept_cherno/ui/widgets/difficulty_selector.dart';
import 'package:retsept_cherno/ui/widgets/ingredients.dart';
import 'package:retsept_cherno/ui/widgets/number_selector.dart';
import 'package:retsept_cherno/ui/widgets/section_title.dart';
import 'package:retsept_cherno/ui/widgets/text_field.dart';
import 'package:retsept_cherno/ui/widgets/time_field.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  int _serving = 4;
  int _selectedDifficulty = 0;
  final List<String> _selectedDishTypes = [];
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });

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
              SectionTitle(title: "Name"),
              const SizedBox(height: 5),
              CustomTextField(hint: "Name your recipe"),
              const SizedBox(height: 10),
              SectionTitle(title: "Number"),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Serving for"),
                  const SizedBox(height: 16),
                  NumberSelector(
                    serving: _serving,
                    onServingChanged: (value) {
                      setState(() {
                        _serving = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SectionTitle(title: "Cook Time"),
              const SizedBox(height: 10),
              Row(
                children: [
                  TimeField(label: "h"),
                  const SizedBox(width: 10),
                  TimeField(label: "m"),
                ],
              ),
              const SizedBox(height: 10),
              SectionTitle(title: "Difficulty"),
              const SizedBox(height: 10),
              DifficultySelector(
                selectedDifficulty: _selectedDifficulty,
                onDifficultyChanged: (index) {
                  setState(() {
                    _selectedDifficulty = index;
                  });
                },
              ),
              const SizedBox(height: 10),
              SectionTitle(title: "Dish Type"),
              const SizedBox(height: 8),
              BuildChipSelectorWidget(
                options: [
                  'Breakfast',
                  'Lunch',
                  'Snack',
                  'Brunch',
                  'Dessert',
                  'Dinner',
                  'Appetizers'
                ],
                selectedOptions: _selectedDishTypes,
                onSelectionChanged: (selectedOptions) {
                  setState(() {
                    _selectedDishTypes.clear();
                    _selectedDishTypes.addAll(selectedOptions);
                  });
                },
              ),
              const SizedBox(height: 20),
              SectionTitle(title: "Hashtags"),
              CustomTextField(hint: "#egg #Vegan #Sugarfree #lowfat"),
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
}
