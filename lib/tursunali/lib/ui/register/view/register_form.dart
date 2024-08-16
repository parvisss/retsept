import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import '../../../../../ui/screens/tab_box_screen.dart';
import '../register.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400,
            ],
          ),
        ),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Registration Failure')),
                );
            }

            if (state.status.isSuccess) {
              // Handle navigation or show a success message
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TabBoxScreen(),
                ),
              ); // Example
            }
          },
          builder: (context, state) {
            if (state.status.isInProgress) {
              return Center(
                child: SpinKitThreeInOut(
                  itemBuilder: (context, index) {
                    return const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.amber),
                    );
                  },
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 60),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1400),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: <Widget>[
                                    _buildTextField(
                                      controller: _nameController,
                                      hintText: 'Fullname',
                                      errorText: state.name.displayError != null
                                          ? 'Invalid name'
                                          : null,
                                      onChanged: (name) {
                                        context
                                            .read<RegisterBloc>()
                                            .add(RegisterNameChanged(name));
                                      },
                                    ),
                                    _buildTextField(
                                      controller: _emailController,
                                      hintText: 'Email',
                                      errorText:
                                          state.email.displayError != null
                                              ? 'Invalid email'
                                              : null,
                                      onChanged: (email) {
                                        context
                                            .read<RegisterBloc>()
                                            .add(RegisterEmailChanged(email));
                                      },
                                    ),
                                    _buildTextField(
                                      controller: _passwordController,
                                      hintText: 'Password',
                                      obscureText: true,
                                      errorText:
                                          state.password.displayError != null
                                              ? 'Invalid password'
                                              : null,
                                      onChanged: (password) {
                                        context.read<RegisterBloc>().add(
                                            RegisterPasswordChanged(password));
                                      },
                                    ),
                                    _buildTextField(
                                      controller: _confirmPasswordController,
                                      hintText: 'Confirm Password',
                                      obscureText: true,
                                      errorText:
                                          state.confirmPassword.displayError !=
                                                  null
                                              ? 'Passwords do not match'
                                              : null,
                                      onChanged: (confirmPassword) {
                                        context.read<RegisterBloc>().add(
                                            RegisterConfirmPasswordChanged(
                                                confirmPassword));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1600),
                              child: MaterialButton(
                                key: const Key(
                                    'registerForm_submit_raisedButton'),
                                onPressed: () {
                                  if (state.isValid) {
                                    context
                                        .read<RegisterBloc>()
                                        .add(const RegisterSubmitted());
                                  }
                                },
                                height: 50,
                                color: Colors.orange[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1500),
                              child: RichText(
                                text: TextSpan(
                                  text: "Already have an account? ",
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: 'Log In',
                                      style:
                                          const TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pop(context);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: FadeInUp(
                                    duration:
                                        const Duration(milliseconds: 1800),
                                    child: MaterialButton(
                                      onPressed: () {},
                                      height: 50,
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Facebook",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Expanded(
                                  child: FadeInUp(
                                    duration:
                                        const Duration(milliseconds: 1900),
                                    child: MaterialButton(
                                      onPressed: () {},
                                      height: 50,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      color: Colors.black,
                                      child: const Center(
                                        child: Text(
                                          "Google",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    String? errorText,
    required Function(String) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          errorText: errorText,
        ),
      ),
    );
  }
}
