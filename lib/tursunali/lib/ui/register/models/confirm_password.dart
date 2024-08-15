import 'package:formz/formz.dart';

enum PasswordValidationError { empty, mismatch }

class ConfirmPassword extends FormzInput<String, PasswordValidationError> {
  const ConfirmPassword.pure() : super.pure('');
  const ConfirmPassword.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    return null;
  }
}
