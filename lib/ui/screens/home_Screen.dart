import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_event.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_state.dart';
import 'package:retsept_cherno/bloc/user/user_bloc.dart';
import 'package:retsept_cherno/bloc/user/user_event.dart';
import 'package:retsept_cherno/services/firestore/retsept/retsept_firebase.dart';
import 'package:retsept_cherno/ui/widgets/home/carusel_item.dart';
import 'package:retsept_cherno/ui/widgets/home/classic_victoria.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<RetseptBloc>().add(LoadRetsepts());
    context.read<UserBloc>().add(LoadUserDataEvent());

    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                  return ListView(
                    children: [
                      // CaruselItemlarni ko'rsatish
                      SizedBox(
                        height: 350.0,
                        child: PageView(
                          controller: _pageController,
                          children: const [
                            CaruselItem(
                              imagePath: 'assets/food2.png',
                              title: 'Strawberry',
                            ),
                            CaruselItem(
                              imagePath: 'assets/food3.png',
                              title: 'Berry',
                            ),
                            CaruselItem(
                              imagePath: 'assets/food10.png',
                              title: 'Egg',
                            ),
                            CaruselItem(
                              imagePath: 'assets/food5.png',
                              title: 'Meat',
                            ),
                            CaruselItem(
                              imagePath: 'assets/food6.png',
                              title: 'Strawberry cake',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      // Retseptlar ro'yxati
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.props.length,
                        itemBuilder: (ctx, index) {
                          final retsetsept = state.props[index];
                          return ClassicVictoria(retsept: retsetsept);
                        },
                      ),
                    ],
                  );
                }
                return const Center(
                  child: Text("Empty data"),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
