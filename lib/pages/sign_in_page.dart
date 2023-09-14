import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/pages/home_page.dart';

import '../blocs/auth/auth_bloc.dart';
import '../services/strings.dart';
import '../views/custom_text_field_view.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);


  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }

        if(state is SignInSuccess) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
        }
      },
  child: Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// #text: sing in
                Text(
                  I18N.signin,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),

                CustomTextField(controller: emailController, title: I18N.email),
                CustomTextField(controller: passwordController, title: I18N.password),



                /// #button: sign up
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(SignInEvent(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),));
                  },
                  child: const Text(I18N.signin),
                ),
                const SizedBox(height: 30),

                /// #already have account
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: I18N.dontHaveAccount,
                      ),
                      TextSpan(
                        text: I18N.signup,
                        style: const TextStyle(color: Colors.lightBlueAccent),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    ),
);
  }
}




