import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/config/config.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/repositories/repositories.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class AuthenticationWidget extends StatefulWidget {
  final bool isRegister;
  // final Function toMenu;

  const AuthenticationWidget({
    super.key,
    required this.isRegister,
    // required this.toMenu,
  });

  @override
  State<AuthenticationWidget> createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  bool isResetting = false;
  bool showPassword = false;
  bool validEmail = false;
  bool validPassword = false;
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  TextEditingController emailCont = TextEditingController();
  TextEditingController nameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailCont.text = context.read<AuthenticationCubit>().state.email;
  }

  void checkEmail(BuildContext context) {
    var email = context.read<AuthenticationCubit>().state.email;

    if (EmailValidator.validate(email)) {
      setState(() {
        validEmail = true;
      });
    } else {
      if (email != '') {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text("Enter a valid email."),
            ),
          );
      }

      setState(() {
        validEmail = false;
      });
    }
  }

  void closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void dispose() {
    emailCont.dispose();
    nameCont.dispose();
    passwordCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 25,
            left: 20,
            right: 20,
            top: 25,
          ),
          child: Column(
            children: [
              widget.isRegister
                  ? SizedBox(
                      width: 400,
                      child: CustomTextField(
                        label: 'Name',
                        cont: nameCont,
                        onChange: (value) {
                          context
                              .read<AuthenticationCubit>()
                              .nameChanged(value);
                        },
                        onEditComplete: () {
                          checkEmail(context);
                        },
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: widget.isRegister ? 25 : 0,
                width: double.infinity,
              ),
              SizedBox(
                // width: 400,
                width:
                    Responsive.isMobile(context) || Responsive.isTablet(context)
                        ? MediaQuery.of(context).size.width - 50
                        : 400,
                child: Focus(
                  // onKey: (focusNode, event) {
                  //   if (event.logicalKey == LogicalKeyboardKey.tab) {
                  //     checkEmail(context);
                  //   }
                  //   return KeyEventResult.ignored;
                  // },
                  onKeyEvent: (node, event) {
                    if (event.logicalKey == LogicalKeyboardKey.tab) {
                      checkEmail(context);
                    }
                    return KeyEventResult.ignored;
                  },
                  child: CustomTextField(
                    label: 'Email',
                    cont: emailCont,
                    focusNode: emailFocus,
                    onChange: (value) {
                      context.read<AuthenticationCubit>().emailChanged(value);
                    },
                    onEditComplete: () {
                      checkEmail(context);
                      closeKeyboard();
                    },
                    onTapOutside: (value) {
                      if (emailFocus.hasFocus) {
                        checkEmail(context);
                        closeKeyboard();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    // width: MediaQuery.of(context).size.width - 95,
                    width: Responsive.isMobile(context) ||
                            Responsive.isTablet(context)
                        ? MediaQuery.of(context).size.width - 95
                        : 355,
                    child: CustomTextField(
                      label: 'Password',
                      cont: passwordCont,
                      focusNode: passwordFocus,
                      obscure: showPassword ? false : true,
                      onChange: (value) {
                        context
                            .read<AuthenticationCubit>()
                            .passwordChanged(value);
                      },
                      onEditComplete: !validEmail ||
                              state.password == '' ||
                              (widget.isRegister && !validPassword)
                          ? null
                          : () {
                              if (widget.isRegister) {
                                context.read<AuthBloc>().add(
                                      RegisterWithEmailAndPassword(
                                        email: state.email,
                                        name: state.name,
                                        password: state.password,
                                      ),
                                    );
                              } else {
                                context.read<AuthBloc>().add(
                                      LoginWithEmailAndPassword(
                                        email: state.email,
                                        password: state.password,
                                      ),
                                    );
                              }
                            },
                      onTap: () {
                        if (!validEmail) {
                          checkEmail(context);
                        }
                      },
                      onTapOutside: (value) {
                        if (passwordFocus.hasFocus) {
                          checkEmail(context);
                          closeKeyboard();
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () => setState(() {
                      showPassword = !showPassword;
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              widget.isRegister
                  ? FlutterPwValidator(
                      controller: passwordCont,
                      minLength: 8,
                      uppercaseCharCount: 1,
                      numericCharCount: 1,
                      specialCharCount: 1,
                      defaultColor: Theme.of(context).colorScheme.surface,
                      failureColor: cgRedViolet,
                      successColor: cgGreen1,
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
                    )
                  : const SizedBox(),
              widget.isRegister
                  ? const SizedBox()
                  : isResetting
                      ? const CircularProgressIndicator()
                      : TextButton(
                          onPressed: () async {
                            var scaffCont = ScaffoldMessenger.of(context);

                            if (!validEmail) {
                              scaffCont
                                ..clearSnackBars()
                                ..showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 3),
                                    content: Text('Enter a valid email.'),
                                  ),
                                );
                            } else {
                              setState(() {
                                isResetting = true;
                              });
                              try {
                                await context
                                    .read<AuthRepository>()
                                    .resetPassword(email: emailCont.text);

                                scaffCont
                                  ..clearSnackBars()
                                  ..showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 3),
                                      content: Text(
                                        'A password reset was sent to the email provided.',
                                      ),
                                    ),
                                  );
                              } catch (err) {
                                print(err);
                                scaffCont
                                  ..clearSnackBars()
                                  ..showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 3),
                                      content: Text('There was an error: $err'),
                                    ),
                                  );
                              }
                              setState(() {
                                isResetting = false;
                              });
                            }
                          },
                          child: const Text('Reset Password'),
                        ),
              const SizedBox(height: 50),
              state.status == AuthenticationStatus.submitting
                  ? const Padding(
                      padding: EdgeInsets.all(11),
                      child: SizedBox(
                        height: 35,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : GameButton(
                      isIconic: false,
                      icon: widget.isRegister
                          ? Icons.app_registration
                          : Icons.login,
                      title: widget.isRegister ? 'Register' : 'Login',
                      onPress: !validEmail ||
                              (widget.isRegister &&
                                  (!context
                                          .read<AuthenticationCubit>()
                                          .state
                                          .isRegisterValid ||
                                      !validPassword)) ||
                              (!widget.isRegister &&
                                  !context
                                      .read<AuthenticationCubit>()
                                      .state
                                      .isLoginValid)
                          ? null
                          : () {
                              if (widget.isRegister) {
                                context.read<AuthBloc>().add(
                                      RegisterWithEmailAndPassword(
                                        email: state.email,
                                        name: state.name,
                                        password: state.password,
                                      ),
                                    );
                              } else {
                                context.read<AuthBloc>().add(
                                      LoginWithEmailAndPassword(
                                        email: state.email,
                                        password: state.password,
                                      ),
                                    );
                              }
                            },
                    ),
            ],
          ),
        );
      },
    );
  }
}
