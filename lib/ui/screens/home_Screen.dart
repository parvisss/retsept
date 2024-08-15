import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_event.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_state.dart';
import 'package:retsept_cherno/services/firestore/retsept_firebase.dart';
import 'package:retsept_cherno/ui/widgets/bottom_navigation_bar.dart';
import 'package:retsept_cherno/ui/widgets/classic_victoria.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageList = [
    'assets/food2.png',
    'assets/food3.png',
    'assets/food4.png',
    'assets/food5.png',
  ];
  @override
  void initState() {
    context.read<RetseptBloc>().add(LoadRetsepts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            RetseptBloc(RetseptFirebase())..add(LoadRetsepts()),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue,
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<RetseptBloc, RetseptState>(
                builder: (context, state) {
              if (state is RetseptLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RetseptError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(state.message),
                  ),
                );
              }
              if (state is RetseptLoaded) {
                return ListView.builder(
                  itemCount: state.props.length,
                  itemBuilder: (ctx, index) {
                    final retsetsept = state.props[index];
                    return ClassicVictoria(retsept: retsetsept);
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(), // Updated with custom bottom navigation
    );
  }
}
