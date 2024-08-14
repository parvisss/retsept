import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/widgets/route.dart';
import 'package:go_router/go_router.dart';

class Splash2Screen extends StatefulWidget {
  @override
  State<Splash2Screen> createState() => _Splash2ScreenState();
}

class _Splash2ScreenState extends State<Splash2Screen> {
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 3), () {
      context.goNamed(AppRoutes.profileSettings); // Bu yerda nom to'g'irlandi
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: _buildFoodItem('assets/food2.png'),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: _buildFoodItem('assets/food3.png'),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: _buildFoodItem('assets/food4.png'),
              ),
              SizedBox(height: 32.0),
              Text(
                'Your personal guide to be a chef',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodItem(String imagePath) {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
