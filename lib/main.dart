import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_bloc.dart';
import 'package:retsept_cherno/bloc/user/user_bloc.dart';
import 'package:retsept_cherno/services/firestore/retsept_firestore.dart';
import 'package:retsept_cherno/services/firestore/user_firestore.dart';
import 'package:retsept_cherno/ui/screens/home_Screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RetseptBloc(RetseptFirestore()),
        ),
        BlocProvider(
          create: (context) => UserBloc(UserFirestore()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
