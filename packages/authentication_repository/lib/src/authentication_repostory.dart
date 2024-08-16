import 'dart:async';
import 'package:authentication_repository/authentication_repostory.dart';

enum AuthenticationStatus {
  initial,
  authenticated,
  unauthenticated,
  error,
  loading,
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _authController = StreamController<Auth>();
  final AuthenticationService _authenticationService;

  AuthenticationRepository({
    required AuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final auth = await _authenticationService.login(email, password);
      _authController.add(auth);
      _controller.add(AuthenticationStatus.authenticated);
      await LocalDb.saveToken(auth.idToken);
    } catch (e) {
      _controller.add(AuthenticationStatus.error);
    }
  }

  Future<Auth> register({
    required String email,
    required String password,
  }) async {
    try {
      final auth = await _authenticationService.register(email, password);
      _authController.add(auth);
      _controller.add(AuthenticationStatus.authenticated);
      await LocalDb.saveToken(auth.idToken);
      return auth;
    } catch (e) {
      _controller.add(AuthenticationStatus.error);
      rethrow;
    }
  }

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    final token = await LocalDb.getIdToken();
    if (token != null && token.isNotEmpty) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Stream<Auth> get auth async* {
    yield* _authController.stream;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
    LocalDb.deleteToken();
  }

  Future<Auth?> getAuthUser() async {
    final response = await _authenticationService.getUserInfo();
    if (response != null) {
      return Auth.fromList(response["users"], await LocalDb.getIdToken());
    }
    return null;
  }

  void dispose() {
    _controller.close();
    _authController.close();
  }
}
