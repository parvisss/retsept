import 'package:authentication_repository/authentication_repostory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/tursunali/lib/bloc/authentication/bloc/authentication_bloc.dart';
import 'package:retsept_cherno/tursunali/lib/services/auth_service.dart/authentication_service.dart';
import 'package:retsept_cherno/tursunali/lib/services/user_service/user_service.dart';
import 'package:retsept_cherno/tursunali/lib/ui/login/views/login_page.dart';
import 'package:retsept_cherno/ui/screens/home_Screen.dart';
import 'package:retsept_cherno/ui/screens/profile_screen.dart';
import 'package:retsept_cherno/ui/screens/splash_screen1.dart';
import 'package:user_repository/user_repostory.dart';

import 'ui/widgets/bottom_navigation_bar.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationService _authenticationService;
  late final UserService _userService;
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationService = FirebaseAuthenticationService();
    _userService = FirebaseUserService();

    _authenticationRepository = AuthenticationRepository(
      authenticationService: _authenticationService,
    );
    _userRepository = UserRepository(userService: _userService);
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider.value(
          value: _userRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (_) => AuthenticationBloc(
              authenticationRepository: _authenticationRepository,
            )..add(AuthenticationSubscriptionRequested()),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/profile': (context) => ProfileScreen(), // Profil sahifasi
      },
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const TabBoxScreen()),
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const HomeScreen()),
                );
                break;
              case AuthenticationStatus.initial:
                break;
              case AuthenticationStatus.error:
              case AuthenticationStatus.loading:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const Splash1Screen());
      },
    );
  }
}
