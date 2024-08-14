import 'package:flutter/material.dart';
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RetseptScreen());
  }
}
