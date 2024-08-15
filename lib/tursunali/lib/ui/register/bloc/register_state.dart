part of 'register_bloc.dart';

final class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.name = const Name.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final Name name;
  final bool isValid;

  RegisterState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    Name? name,
    bool? isValid,
  }) {
    return RegisterState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      name: name ?? this.name,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, email, password, confirmPassword, name, isValid];
}