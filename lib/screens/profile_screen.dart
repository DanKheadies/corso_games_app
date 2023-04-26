import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/repositories/repositories.dart';
import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => UserBloc(
          authBloc: context.read<AuthBloc>(),
          userRepository: context.read<UserRepository>(),
        )..add(
            LoadUser(
              context.read<AuthBloc>().state.authUser,
            ),
          ),
        child: const ProfileScreen(),
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Profile',
      infoTitle: 'Your Profile',
      infoDetails: 'See your account. Make updates. Ya know, that stuff.',
      backgroundOverride: Colors.transparent,
      content: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserLoaded) {
            if (context.read<AuthBloc>().state.authUser!.email == null) {
              // return Column(
              //   children: [
              //     Text('Derp'),
              //     Registration(
              //       isAnon: true,
              //       updateEmail: (value) {
              //         context.read<SignUpCubit>().emailChanged(value);
              //       },
              //     ),
              //   ],
              // );
              return Registration(
                isAnon: true,
                updateEmail: (value) {
                  context.read<SignUpCubit>().emailChanged(value);
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, cubitState) {
                        if (cubitState.status == LoginStatus.error) {
                          var errorMessage = 'Authentication failed.';
                          if (cubitState.errorMessage!
                              .contains('user-not-found')) {
                            errorMessage =
                                'There is no account associated with this email.';
                          } else if (cubitState.errorMessage!
                              .contains('wrong-password')) {
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
                        } else if (cubitState.status == LoginStatus.reset) {
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
                            // Text(
                            //   'Your Profile',
                            //   style: Theme.of(context).textTheme.headlineSmall,
                            // ),
                            const SizedBox(height: 25),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 75,
                                    child: Text(
                                      'Email',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      state.user.email,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            ActionLink(
                              text: 'Reset Password',
                              resetLink:
                                  cubitState.status == LoginStatus.initial ||
                                      cubitState.status == LoginStatus.error,
                              isDisable: false,
                              onTap: () {
                                context.read<LoginCubit>().resetPassword(
                                      email: state.user.email,
                                    );
                              },
                            ),
                            const SizedBox(height: 25),
                            CustomTextFormField(
                              title: 'Name',
                              initialValue: state.user.fullName,
                              onSave: (value) {
                                context.read<UserBloc>().add(
                                      UpdateUser(
                                        user: state.user.copyWith(
                                          fullName: value,
                                        ),
                                      ),
                                    );
                              },
                            ),
                            const SizedBox(height: 25),
                          ],
                        );
                      },
                    ),
                    Column(
                      children: [
                        ActionLink(
                          text: 'Sign Out',
                          resetLink: false,
                          isDisable: false,
                          onTap: () {
                            // var nav = Navigator.of(context);
                            // await context.read<AuthRepository>().signOut();
                            // nav.pushNamedAndRemoveUntil('/', (route) => false);

                            context.read<AuthRepository>().signOut();
                            context.read<LoginCubit>().signOut();
                            context.read<SignUpCubit>().signOut();

                            Navigator.of(context).pushNamedAndRemoveUntil(
                              SplashScreen.routeName,
                              (route) => false,
                            );
                          },
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ],
                  // ),
                ),
              );
            }
          } else {
            return const Center(
              child: Text('Something went wrong.'),
            );
          }
        },
      ),
      screenFunction: (String string) {},
      bottomBar: const SizedBox(),
    );
  }
}
