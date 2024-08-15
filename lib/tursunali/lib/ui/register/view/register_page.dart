import 'package:authentication_repository/authentication_repostory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repostory.dart';

import '../register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: BlocProvider(
          create: (context) => RegisterBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
            userRepository: context.read<UserRepository>(),
          ),
          child: const RegisterForm(),
        ),
      ),
    );
  }
}
