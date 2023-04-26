import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
// import 'package:corso_games_app/repositories/repositories.dart';
import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const WelcomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  bool _contentVisible = false;

  late AnimationController _controller;
  late Timer _showContentTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(
        seconds: 2,
      ),
      vsync: this,
    );

    _showContentTimer = Timer(
      const Duration(milliseconds: 600),
      showContent,
    );

    _controller.forward();

    _controller.addListener(() {
      setState(() {});
    });

    _showContentTimer;
  }

  void showContent() {
    if (!_contentVisible) {
      setState(() {
        _contentVisible = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _showContentTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        // print('welcome listener triggered');
        if (state.authUser != null &&
            state.status == AuthStatus.authenticated) {
          // print('welcome is authUser & auth\'d so push');

          if (state.user!.lastLogin != '') {
            context.read<LoginCubit>().updateLogin(
                  user: state.user!,
                );
          }

          Navigator.of(context).pushNamedAndRemoveUntil(
            GamesScreen.routeName,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AnimatedOpacity(
          opacity: _contentVisible ? 1 : 0,
          duration: const Duration(
            milliseconds: 1000,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<BrightnessCubit, Brightness>(
                  builder: (context, state) {
                    return SizedBox(
                      // width:
                      child: Image.asset(
                        state == Brightness.dark
                            ? 'assets/images/main/corso-games-2.png'
                            : 'assets/images/main/corso-games-1.png',
                      ),
                    );
                  },
                ),
                Column(
                  children: [
                    GameButton(
                      isIconic: false,
                      icon: Icons.login,
                      title: 'Log In',
                      onPress: () => Navigator.of(context)
                          .pushNamed(LoginScreen.routeName),
                    ),
                    const SizedBox(height: 35),
                    GameButton(
                      isIconic: false,
                      icon: Icons.app_registration_rounded,
                      title: 'Sign Up',
                      onPress: () => Navigator.of(context)
                          .pushNamed(RegistrationScreen.routeName),
                    ),
                    const SizedBox(height: 45),
                    BlocBuilder<SignUpCubit, SignUpState>(
                      builder: (context, state) {
                        if (state.status == SignUpStatus.initial) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: ActionLink(
                              text: 'Maybe Later',
                              resetLink: false,
                              isDisable: false,
                              onTap: () => context
                                  .read<SignUpCubit>()
                                  .signUpAnonymously(),
                            ),
                          );
                        }
                        if (state.status == SignUpStatus.submitting) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 22,
                            ),
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          );
                        }
                        if (state.status == SignUpStatus.success) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Text(
                              'Succes! Try closing and re-opening the app.',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
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
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          );
                        }
                      },
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
  }
}
