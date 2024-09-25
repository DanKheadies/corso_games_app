import 'dart:async';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/config/config.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthMethod {
  login,
  register,
  tbd,
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AuthMethod method = AuthMethod.tbd;
  bool contentVisible = false;
  bool imageLinkVisible = false;

  late AnimationController controller;
  late Timer authenticationTimer;
  late Timer showContentTimer;
  late Timer showImageLinkTimer;

  @override
  void initState() {
    super.initState();

    authenticationTimer = Timer(Duration.zero, () {});

    controller = AnimationController(
      duration: const Duration(
        seconds: 2,
      ),
      vsync: this,
    );

    showContentTimer = Timer(
      const Duration(milliseconds: 600),
      showContent,
    );

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });

    showContentTimer;
  }

  void showContent() {
    int duration = 300;
    if (!contentVisible) {
      duration = 0;
      setState(() {
        contentVisible = true;
      });
    }
    if (!imageLinkVisible) {
      showImageLinkTimer = Timer(
        Duration(milliseconds: duration),
        () => setState(() {
          imageLinkVisible = true;
        }),
      );
    }
  }

  Future<void> handleError(
    AuthState state,
    BuildContext context,
  ) async {
    var authCont = context.read<AuthBloc>();
    var scaffCont = ScaffoldMessenger.of(context);

    String errorMsg = state.errorMessage!
        .replaceAll('Exception: ', '')
        .replaceAll(RegExp('\\[.*?\\]'), '')
        .trim();

    await Future.delayed(const Duration(milliseconds: 300));

    scaffCont
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(errorMsg),
        ),
      );

    authCont.add(
      ResetError(),
    );
  }

  @override
  void dispose() {
    authenticationTimer.cancel();
    controller.dispose();
    showContentTimer.cancel();
    showImageLinkTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ScreenWrapper(
      screen: method == AuthMethod.login
          ? 'Login'
          : method == AuthMethod.register
              ? 'Register'
              : 'CruiseCalls',
      actions: [
        IconButton(
          icon: Icon(
            context.read<BrightnessCubit>().state == Brightness.dark
                ? Icons.dark_mode
                : Icons.light_mode,
          ),
          onPressed: () {
            context.read<BrightnessCubit>().toggleBrightness();
          },
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomBar: const SizedBox(),
      button: 'GG',
      hasAppBar: method == AuthMethod.tbd ? false : true,
      hasDrawer: false,
      useSingleScroll: true,
      flactionButton: method != AuthMethod.tbd
          ? GameButton(
              isIconic: false,
              icon: Icons.arrow_back,
              title: '',
              onPress: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                showContent();
                setState(() {
                  method = AuthMethod.tbd;
                });
              },
            )
          : null,
      infoTitle: 'Corso Games',
      infoDetails:
          'Welcome to Corso Games. Login or sign up to play. Have a request? Reach out to us at support@holisticgaming.com.',
      screenFunction: (_) {},
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status == AuthStatus.submitting) {
            return CustomCenter(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            );
          } else if (state.status == AuthStatus.authenticated) {
            if (!authenticationTimer.isActive) {
              print('not active so setting');
              authenticationTimer = Timer(
                const Duration(seconds: 3),
                () async {
                  print('its been 3 seconds and still here, sign out');
                  context.read<AuthBloc>().add(
                        SignOut(),
                      );
                },
              );
            }

            return CustomCenter(
              child: GestureDetector(
                onLongPress: () {
                  context.read<AuthBloc>().add(
                        SignOut(),
                      );
                },
                child: Icon(
                  Icons.thumb_up_alt_outlined,
                  color: method != AuthMethod.tbd
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context).colorScheme.primary,
                  size: 50,
                ),
              ),
            );
          } else {
            // TODO: this spams if email in use (i.e. doesn't get cleared)
            if (state.errorMessage != '' && state.errorMessage != null) {
              handleError(state, context);
            }

            if (method == AuthMethod.tbd) {
              return SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: GestureDetector(
                  onTap: () {
                    showContentTimer.cancel();

                    setState(() {
                      contentVisible = true;
                    });
                  },
                  child: AnimatedOpacity(
                    opacity: contentVisible ? 1 : 0,
                    duration: const Duration(
                      milliseconds: 1000,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(),
                          AnimatedOpacity(
                            opacity: imageLinkVisible ? 1 : 0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                            child: BlocBuilder<BrightnessCubit, Brightness>(
                              builder: (context, state) {
                                return SizedBox(
                                  width: Responsive.isMobile(context) ||
                                          Responsive.isTablet(context)
                                      ? double.infinity
                                      : screenSize.height / 1.5,
                                  child: Image.asset(
                                    state == Brightness.dark
                                        ? 'assets/images/main/corso-games-2.png'
                                        : 'assets/images/main/corso-games-1.png',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: double.infinity),
                          Column(
                            children: [
                              GameButton(
                                isIconic: false,
                                icon: Icons.login,
                                title: 'Log In',
                                onPress: showContentTimer.isActive
                                    ? () {}
                                    : () {
                                        setState(() {
                                          imageLinkVisible = false;
                                          method = AuthMethod.login;
                                        });
                                      },
                              ),
                              const SizedBox(height: 35),
                              GameButton(
                                isIconic: false,
                                icon: Icons.app_registration_rounded,
                                title: 'Sign Up',
                                onPress: showContentTimer.isActive
                                    ? () {}
                                    : () {
                                        setState(() {
                                          imageLinkVisible = false;
                                          method = AuthMethod.register;
                                        });
                                      },
                              ),
                              const SizedBox(height: 45),
                              AnimatedOpacity(
                                opacity: imageLinkVisible ? 1 : 0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                                child: BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    if (state.status ==
                                            AuthStatus.unauthenticated ||
                                        state.status == AuthStatus.unknown) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: ActionLink(
                                          text: 'Maybe Later, Play Now',
                                          resetLink: false,
                                          isDisable: false,
                                          onTap: () {
                                            context.read<AuthBloc>().add(
                                                  const RegisterAnonymously(),
                                                );
                                          },
                                        ),
                                      );
                                    }
                                    if (state.status == AuthStatus.submitting) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 2,
                                        ),
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        ),
                                      );
                                    }
                                    if (state.status ==
                                        AuthStatus.authenticated) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Text(
                                          'Succes! Try closing and re-opening the app.',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Text(
                                          'Something went wrong.',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return AuthenticationWidget(
                isRegister: method == AuthMethod.register ? true : false,
              );
            }
          }
        },
      ),
    );
  }
}
