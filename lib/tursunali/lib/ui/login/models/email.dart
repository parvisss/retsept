import 'package:formz/formz.dart';

// Enum to define validation errors
enum EmailValidationError { empty, invalid }

// Email class extending FormzInput
class Email extends FormzInput<String, EmailValidationError> {
  // Constructor for a pure (uninitialized) instance
  const Email.pure() : super.pure('');

  // Constructor for a dirty (initialized) instance
  const Email.dirty([super.value = '']) : super.dirty();

  // Validator function to validate the email format
  @override
  EmailValidationError? validator(String value) {
    // Check if the value is empty
    if (value.isEmpty) return EmailValidationError.empty;

    // Regular expression for validating an email address
    final emailRegExp = RegExp(
      r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
    );

    // Check if the value matches the regular expression
    if (!emailRegExp.hasMatch(value)) return EmailValidationError.invalid;

    // Return null if validation passes
    return null;
  }
}
