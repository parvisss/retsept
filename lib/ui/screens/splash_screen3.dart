import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/screens/splash_screen4.dart';
import 'package:flutter_application_2/ui/widgets/route.dart';
import 'package:go_router/go_router.dart';

class SplashScreen3 extends StatefulWidget {
  @override
  State<SplashScreen3> createState() => _SplashScreen3State();
}

class _SplashScreen3State extends State<SplashScreen3> {
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Splash4Screen();
          },
        ),
      );    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.yellow,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: _buildFoodItem('assets/food8.png'),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: _buildFoodItem('assets/food10.png'),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: _buildFoodItem('assets/food11.png'),
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
