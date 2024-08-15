part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.initial,
    this.user = Auth.empty,
  });

  const AuthenticationState.initial() : this._();

  const AuthenticationState.authenticated(Auth user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final Auth user;

  @override
  List<Object> get props => [status, user];
}
