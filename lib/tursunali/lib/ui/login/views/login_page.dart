import 'package:authentication_repository/authentication_repostory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/tursunali/lib/ui/login/bloc/login_bloc.dart';
import 'package:retsept_cherno/tursunali/lib/ui/login/views/login_form.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: BlocProvider(
          create: (context) => LoginBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
