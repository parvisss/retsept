import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retsept_cherno/tursunali/lib/ui/register/bloc/register_bloc.dart';
import 'package:retsept_cherno/tursunali/lib/ui/register/models/confirm_password.dart';
import 'package:retsept_cherno/tursunali/lib/ui/register/models/email.dart';
import 'package:retsept_cherno/tursunali/lib/ui/register/models/name.dart';
import 'package:retsept_cherno/tursunali/lib/ui/register/models/password.dart';
import 'package:retsept_cherno/tursunali/lib/ui/register/view/register_form.dart';

// Create a mock RegisterBloc class using Mock from mocktail
class MockRegisterBloc extends Mock implements RegisterBloc {}

void main() {
  late MockRegisterBloc mockRegisterBloc;

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
    // Mock the initial state of the RegisterBloc
    when(() => mockRegisterBloc.state).thenReturn(const RegisterState(
      email: Email.dirty(''),
      password: Password.dirty(''),
      confirmPassword: ConfirmPassword.dirty(''),
      name: Name.dirty(''),
    ));
  });

  tearDown(() {
    mockRegisterBloc.close();
  });

  testWidgets('RegisterForm renders and interacts correctly',
      (WidgetTester tester) async {
    // Build the widget tree with the RegisterForm
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RegisterBloc>.value(
          value: mockRegisterBloc,
          child: const RegisterForm(),
        ),
      ),
    );

    // Verify if the RegisterForm elements are rendered correctly
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Fullname'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Facebook'), findsOneWidget);
    expect(find.text('Google'), findsOneWidget);

    // Enter text into the form fields
    await tester.enterText(
        find.byKey(const Key('registerForm_nameInput_textField')), 'John Doe');
    await tester.enterText(
        find.byKey(const Key('registerForm_emailInput_textField')),
        'test@example.com');
    await tester.enterText(
        find.byKey(const Key('registerForm_passwordInput_textField')),
        'password123');
    await tester.enterText(
        find.byKey(const Key('registerForm_confirmPasswordInput_textField')),
        'password123');

    // Tap the Register button
    await tester.tap(find.byKey(const Key('registerForm_submit_raisedButton')));
    await tester.pump();

    // Verify that the correct events were added to the bloc
    verify(() => mockRegisterBloc.add(const RegisterNameChanged('John Doe')))
        .called(1);
    verify(() => mockRegisterBloc
        .add(const RegisterEmailChanged('test@example.com'))).called(1);
    verify(() =>
            mockRegisterBloc.add(const RegisterPasswordChanged('password123')))
        .called(1);
    verify(() => mockRegisterBloc
        .add(const RegisterConfirmPasswordChanged('password123'))).called(1);
    verify(() => mockRegisterBloc.add(const RegisterSubmitted())).called(1);
  });
}
