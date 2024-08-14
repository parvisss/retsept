import 'package:flutter/material.dart';

import 'package:flutter_application_2/ui/widgets/route.dart';
import 'package:go_router/go_router.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_bloc.dart';
import 'package:retsept_cherno/bloc/user/user_bloc.dart';
import 'package:retsept_cherno/services/firestore/retsept_firestore.dart';
import 'package:retsept_cherno/services/firestore/user_firestore.dart';
import 'package:retsept_cherno/ui/screens/retsept_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      // the reason what im using multibloc provider here is to globalize bloc also to create blocs before app
      providers: [
        BlocProvider(create: (context) => RetseptBloc(RetseptFirestore())),
        BlocProvider(create: (context) => UserBloc(UserFirestore())),
      ],
      child: const MainApp(),
    ),
  );

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = AppRoutes.config;

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
    );

  }
}
