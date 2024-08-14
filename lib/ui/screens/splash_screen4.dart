import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/widgets/route.dart';
import 'package:go_router/go_router.dart';

class Splash4Screen extends StatefulWidget {
  @override
  State<Splash4Screen> createState() => _Splash4ScreenState();
}

class _Splash4ScreenState extends State<Splash4Screen> {
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      context.goNamed(AppRoutes.homescreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.orange,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: _buildFoodItem('assets/food5.png'),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: _buildFoodItem('assets/food6.png'),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: _buildFoodItem('assets/food7.png'),
              ),
              SizedBox(height: 32.0),
              const Text(
                'Foodify Your Global  Kitchen',
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
