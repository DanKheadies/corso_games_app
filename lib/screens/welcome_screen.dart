import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:timeago/timeago.dart' as timeago;

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/repositories/repositories.dart';
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
      listenWhen: (previous, current) {
        print('listening..');
        if (previous.status != current.status || current.user != null) {
          print('triggered');
          print(previous.status);
          print(current.status);
          print(current.user);
          return true;
        }
        print('do nothing');
        return false;
      },
      listener: (context, state) {
        // print('welcome listener triggered');
        if (state.authUser != null &&
            state.status == AuthStatus.authenticated) {
          // print('welcome is authUser & auth\'d so push');

          Navigator.pushNamedAndRemoveUntil(
            context,
            '/games',
            (route) => false,
          );
        } else {
          // print('welcome no authUser or unauth/known so stay');
          context.read<LoginCubit>().signOut();
          context.read<SignUpCubit>().signOut();

          Navigator.pushNamedAndRemoveUntil(
            context,
            '/welcome',
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
                      onPress: () =>
                          Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login',
                        (route) => !route.isActive,
                      ),
                    ),
                    const SizedBox(height: 35),
                    GameButton(
                      isIconic: false,
                      icon: Icons.app_registration_rounded,
                      title: 'Sign Up',
                      onPress: () =>
                          Navigator.of(context).pushNamedAndRemoveUntil(
                        '/registration',
                        (route) => !route.isActive,
                      ),
                    ),
                    // PaddedButton(
                    //   color: Theme.of(context)
                    //       .colorScheme
                    //       .secondary
                    //       .withOpacity(0.8),
                    //   text: 'Sign Up',
                    //   isDisabled: false,
                    //   onPressed: () =>
                    //       Navigator.of(context).pushNamedAndRemoveUntil(
                    //     '/registration',
                    //     (route) => !route.isActive,
                    //   ),
                    // ),
                    const SizedBox(height: 45),
                    BlocBuilder<SignUpCubit, SignUpState>(
                      builder: (context, state) {
                        if (state.status == SignUpStatus.initial) {
                          // return PaddedButton(
                          //   color: Theme.of(context)
                          //       .colorScheme
                          //       .tertiary
                          //       .withOpacity(0.8),
                          //   text: 'Continue to Cruise Schedules',
                          //   isDisabled: false,
                          //   onPressed: () =>
                          //       context.read<SignUpCubit>().signUpAnonymously(),
                          // );
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ), // Only w/ the trifecta
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
                                vertical: 22), // Only Anon Button
                            // padding: const EdgeInsets.symmetric(
                            //   vertical: 0, // Log, Reg & Anon Buttons
                            // ),
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
                              'Try closing and re-opening the app.',
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
