import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:retsept_cherno/ui/screens/splash_screen2.dart';

class Splash1Screen extends StatefulWidget {
  const Splash1Screen({super.key});

  @override
  _Splash1ScreenState createState() => _Splash1ScreenState();
}

class _Splash1ScreenState extends State<Splash1Screen> {
  @override
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
            return Splash2Screen();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.purple,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/svg/foodify.svg",
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}
