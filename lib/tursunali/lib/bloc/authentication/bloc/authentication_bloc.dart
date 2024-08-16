import 'dart:async';

import 'package:authentication_repository/authentication_repostory.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.initial()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onSubscriptionRequested(
  AuthenticationSubscriptionRequested event,
  Emitter<AuthenticationState> emit,
) async {
  await emit.onEach(
    _authenticationRepository.status,
    onData: (status) async {
      switch (status) {
        case AuthenticationStatus.authenticated:
          final user = await _tryGetUser();
          emit(
            user != null
                ? AuthenticationState.authenticated(user)
                : const AuthenticationState.unauthenticated(),
          );
          break;
        case AuthenticationStatus.unauthenticated:
          emit(const AuthenticationState.unauthenticated());
          break;

        case AuthenticationStatus.initial:
          emit(const AuthenticationState.initial());
          break;
        case AuthenticationStatus.error:
        case AuthenticationStatus.loading:
          // Handle loading and error states if needed
          break;
      }
    },
    onError: addError,
  );
}

  Future _onLogoutPressed(
    AuthenticationLogoutPressed event,
    Emitter<AuthenticationState> emit,
  ) async {
    _authenticationRepository.logOut();
    emit(const AuthenticationState.unauthenticated());
  }

  Future<Auth?> _tryGetUser() async {
  try {
     await _authenticationRepository.auth.first;
    final user = await _authenticationRepository.getAuthUser();
    if (user == null) {
    }

    return user;
  } catch (e) {
    return null;
  }
}
}
