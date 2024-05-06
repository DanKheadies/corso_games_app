import 'dart:async';

import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LoginScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.background,
            ),
            tooltip: 'Info Helper',
            onPressed: () => showScreenInfo(
              context,
              'Login',
              'Enter your email and password, or use a 3rd party to verify your account. If you\'ve forgotten you info, try sending yourself a password reset.',
              false,
              TextAlign.center,
              'Let\'s Go',
            ),
          ),
        ],
      ),
      floatingActionButton: GameButton(
        isIconic: false,
        icon: Icons.arrow_back,
        title: '',
        onPress: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserInput(
              labelText: 'Email',
              onChanged: (email) {
                context.read<LoginCubit>().emailChanged(email);
              },
            ),
            const SizedBox(height: 10),
            const PasswordInput(
              isSignUp: false,
            ),
            const SizedBox(height: 50),
            SizedBox(
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state.status == LoginStatus.error) {
                    var errorMessage = 'Authentication failed.';
                    // if (state.errorMessage!
                    //     .contains('email-already-in-use')) {
                    //   errorMessage = 'This email address is already in use.';
                    // }
                    if (state.errorMessage!.contains('user-not-found')) {
                      errorMessage =
                          'There is no account associated with this email.';
                    } else if (state.errorMessage!.contains('wrong-password')) {
                      errorMessage =
                          'That password does not match our records.';
                    }
                    Timer(
                      const Duration(milliseconds: 100),
                      () {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                            ),
                          );
                      },
                    );
                  } else if (state.status == LoginStatus.reset) {
                    Timer(
                      const Duration(milliseconds: 100),
                      () {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'An email has been sent. Check you inbox and spam.'),
                            ),
                          );
                      },
                    );
                  }
                  return Column(
                    children: [
                      // TODO: disable w/ spinner after click
                      // TODO: disable if no email / password (?) snackbars prevent below
                      state.status == LoginStatus.submitting
                          ? const Padding(
                              padding: EdgeInsets.all(11),
                              child: SizedBox(
                                height: 35,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : GameButton(
                              isIconic: false,
                              icon: Icons.login,
                              title: 'Log In',
                              onPress: () {
                                if (state.email == '') {
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(
                                      const SnackBar(
                                        content: Text("Enter an email."),
                                      ),
                                    );
                                } else if (state.password == '') {
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(
                                      const SnackBar(
                                        content: Text("Enter a password."),
                                      ),
                                    );
                                } else if (EmailValidator.validate(
                                        state.email) &&
                                    state.password != '') {
                                  context
                                      .read<LoginCubit>()
                                      .logInWithCredentials();
                                } else {
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(
                                      const SnackBar(
                                        content: Text("Enter a valid email."),
                                      ),
                                    );
                                }
                              },
                            ),
                      const SizedBox(height: 40),
                      ActionLink(
                        text: 'Forgot your password?',
                        resetLink: state.status == LoginStatus.initial ||
                            state.status == LoginStatus.error,
                        // resetLink: false,
                        isDisable: state.status == LoginStatus.submitting,
                        onTap: () {
                          if (EmailValidator.validate(state.email)) {
                            context.read<LoginCubit>().resetPassword(
                                  email: state.email,
                                );
                          } else {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text("Enter a valid email."),
                                ),
                              );
                          }
                        },
                      ),
                      // const SizedBox(height: 10),
                      // const _GoogleLoginButton(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _GoogleLoginButton extends StatelessWidget {
//   const _GoogleLoginButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         context.read<LoginCubit>().logInWithGoogles();
//       },
//       style: ElevatedButton.styleFrom(
//         shape: const RoundedRectangleBorder(),
//         backgroundColor: Colors.white,
//         fixedSize: const Size(200, 40),
//       ),
//       child: Text(
//         'Sign In with Google',
//         style: Theme.of(context).textTheme.headline4!.copyWith(
//               color: Colors.black,
//             ),
//       ),
//     );
//   }
// }
