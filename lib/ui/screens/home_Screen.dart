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
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    context.read<RetseptBloc>().add(LoadRetsepts());
    context.read<UserBloc>().add(LoadUserDataEvent());

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (mounted) {
        setState(() {
          // Change the logic to loop correctly based on the number of items
          if (_currentPage < _pageController.positions.length - 1) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }
        });

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 28),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
      ),
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
                } else if (state is RetseptLoaded) {
                  return Column(
                    children: [
                      // CaruselItemlarni ko'rsatish
                      SizedBox(
                        height: 350.0,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: state
                              .retsepts.length, // Use the length of retsepts
                          itemBuilder: (context, index) {
                            final retsept = state.retsepts[index];
                            return CaruselItem(
                              imagePath: retsept
                                  .image, // Assuming retsept has imagePath field
                              title: retsept
                                  .name, // Assuming retsept has title field
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Retseptlar ro'yxati
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.retsepts.length,
                          itemBuilder: (ctx, index) {
                            final retsept = state.retsepts[index];
                            return ClassicVictoria(retsept: retsept);
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: Text("Empty data"));
              },
            ),
          ),
        ),
      ),
    );
  }
}
