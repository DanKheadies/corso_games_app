import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class Registration extends StatefulWidget {
  final bool isAnon;
  final Function(String)? updateEmail;

  const Registration({
    super.key,
    required this.isAnon,
    this.updateEmail,
  });

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool validEmail = false;
  bool validPassword = false;
  final TextEditingController passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserInput(
                onChanged: (value) {
                  if (EmailValidator.validate(value)) {
                    if (!validEmail) {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text("Email is valid."),
                          ),
                        );
                    }
                    setState(() {
                      validEmail = true;
                    });
                  } else {
                    setState(() {
                      validEmail = false;
                    });
                  }

                  if (widget.updateEmail != null) {
                    widget.updateEmail!(value);
                  } else {
                    context.read<SignUpCubit>().emailChanged(value);
                  }
                },
                labelText: 'Email',
              ),
              const SizedBox(height: 10),
              PasswordInput(
                controller: passwordCont,
                isSignUp: true,
              ),
              const SizedBox(height: 25),
              FlutterPwValidator(
                controller: passwordCont,
                minLength: 8,
                uppercaseCharCount: 1,
                numericCharCount: 1,
                specialCharCount: 1,
                defaultColor:
                    Theme.of(context).colorScheme.surface.withOpacity(0.8),
                failureColor: Theme.of(context).colorScheme.secondary,
                successColor: Theme.of(context).colorScheme.tertiary,
                width: 400,
                height: 150,
                onSuccess: () {
                  if (!validPassword) {
                    setState(() {
                      validPassword = true;
                    });
                  }
                },
                onFail: () {
                  if (validPassword) {
                    setState(() {
                      validPassword = false;
                    });
                  }
                },
              ),
              const SizedBox(height: 25),
              SizedBox(
                child: BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, cubitState) {
                    if (cubitState.status == SignUpStatus.error) {
                      print(cubitState.errorMessage);
                      var errorMessage = 'Authentication failed.';
                      if (cubitState.errorMessage!
                          .contains('email-already-in-use')) {
                        errorMessage = 'This email address is already in use.';
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
                    }
                    return cubitState.status == SignUpStatus.submitting
                        ? const Padding(
                            padding: EdgeInsets.all(10),
                            child: CircularProgressIndicator(),
                          )
                        : validEmail && validPassword
                            ? GameButton(
                                isIconic: false,
                                icon: Icons.app_registration,
                                title: 'Sign Up',
                                onPress: () {
                                  if (validEmail && validPassword) {
                                    if (widget.isAnon) {
                                      context
                                          .read<SignUpCubit>()
                                          .convertWithEmail();

                                      // TODO: save user email on conversion

                                      // context.read<UserBloc>().add(
                                      //   UpdateUser(user: user,),
                                      // );
                                      // context.read<UserBloc>().add(
                                      //   UpdateUser(
                                      //     user: state.user.copyWith(
                                      //       fullName: value,
                                      //     ),
                                      //   ),
                                      // );
                                    } else {
                                      context
                                          .read<SignUpCubit>()
                                          .signUpWithCredentials();
                                    }
                                  }
                                },
                              )
                            : Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.06,
                                  ),
                                ),
                              );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
