import 'dart:async';

import 'models/models.dart';
import 'services/authentication_service.dart';

enum AuthenticationStatus {
  initial,
  authenticated,
  unauthenticated,
  error,
  loading;
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _authController = StreamController<Auth>();
  final AuthenticationService _authenticationService;

  AuthenticationRepository({
    required AuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    // api 'dan ma'lumot kelishi kerak
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Stream<Auth> get auth async* {
    yield* _authController.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final auth = await _authenticationService.login(email, password);
    _authController.add(auth);
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<Auth> register({
    required String email,
    required String password,
  }) async {
    final auth = await _authenticationService.register(email, password);
    _authController.add(auth);
    _controller.add(AuthenticationStatus.authenticated);
    return auth;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
