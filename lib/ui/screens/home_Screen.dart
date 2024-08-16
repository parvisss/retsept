// ignore: file_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_event.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_state.dart';
import 'package:retsept_cherno/bloc/user/user_bloc.dart';
import 'package:retsept_cherno/bloc/user/user_event.dart';
import 'package:retsept_cherno/data/models/retsept_model.dart';
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
        final state = context.read<RetseptBloc>().state;
        final int totalPages = state is RetseptLoaded ? state.retsepts.length : 0;

        setState(() {
          _currentPage = (_currentPage + 1) % totalPages;
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
        create: (context) => RetseptBloc(RetseptFirebase())..add(LoadRetsepts()),
        child: CustomScrollView(
          slivers: [
            BlocBuilder<RetseptBloc, RetseptState>(
              builder: (context, state) {
                if (state is RetseptLoading) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is RetseptError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(state.message),
                      ),
                    ),
                  );
                } else if (state is RetseptLoaded) {
                  final List<RetseptModel> retsepts = state.retsepts;

                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(
                          height: 350.0,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: retsepts.length,
                            itemBuilder: (context, index) {
                              final retsept = retsepts[index];
                              return CaruselItem(
                                imagePath: retsept.image,
                                title: retsept.name,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        // Retseptlar ro'yxati
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              for (var retsept in retsepts)
                                ClassicVictoria(retsept: retsept),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SliverFillRemaining(
                  child: Center(child: Text("Empty data")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
