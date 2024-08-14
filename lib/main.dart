import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/screens/splash_screen1.dart';
import 'package:flutter_application_2/ui/widgets/route.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash1Screen(),
    );
  }
}
