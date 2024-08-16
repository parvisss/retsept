import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retsept_cherno/tursunali/lib/ui/login/bloc/login_bloc.dart';
import 'package:retsept_cherno/tursunali/lib/ui/login/models/email.dart';
import 'package:retsept_cherno/tursunali/lib/ui/login/models/password.dart';
import 'package:retsept_cherno/tursunali/lib/ui/login/views/login_form.dart';

// Create a mock LoginBloc class using Mock from mocktail
class MockLoginBloc extends Mock implements LoginBloc {}

void main() {
  late MockLoginBloc mockLoginBloc;

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    // Mock the initial state of the LoginBloc
    when(() => mockLoginBloc.state).thenReturn(
      const LoginState(
        email: Email.dirty(''),
        password: Password.dirty(''),
      ),
    );
  });

  tearDown(() {
    mockLoginBloc.close();
  });

  testWidgets('LoginForm renders and interacts correctly', (WidgetTester tester) async {
    // Build the widget tree with the LoginForm
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: mockLoginBloc,
          child: const LoginForm(),
        ),
      ),
    );

    // Verify if the LoginForm elements are rendered correctly
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text("Don't have an account?"), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Facebook'), findsOneWidget);
    expect(find.text('Google'), findsOneWidget);

    // Enter email and password
    await tester.enterText(find.byKey(const Key('loginForm_emailInput_textField')), 'test@example.com');
    await tester.enterText(find.byKey(const Key('loginForm_passwordInput_textField')), 'password123');

    // Tap the Login button
    await tester.tap(find.byKey(const Key('loginForm_continue_raisedButton')));
    await tester.pump();

    // Verify that the correct events were added to the bloc
    verify(() => mockLoginBloc.add(const LoginSubmitted())).called(1);
    verify(() => mockLoginBloc.add(const LoginEmailChanged('test@example.com'))).called(1);
    verify(() => mockLoginBloc.add(const LoginPasswordChanged('password123'))).called(1);
  });
}
