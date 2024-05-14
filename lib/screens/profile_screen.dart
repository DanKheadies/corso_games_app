import 'dart:async';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Profile',
      hasDrawer: true,
      infoTitle: 'Your Profile',
      infoDetails: 'See your account. Make updates. Ya know, that stuff.',
      useSingleScroll: true,
      screenFunction: (_) {},
      bottomBar: const SizedBox(),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState.userStatus == UserStatus.initial ||
              userState.userStatus == UserStatus.loading) {
            return GestureDetector(
              onLongPress: () => context.read<AuthBloc>().add(
                    SignOut(),
                  ),
              child: const CustomCenter(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (userState.userStatus == UserStatus.loaded) {
            name = userState.user.name;

            return Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, authState) {
                        if (authState.status == AuthStatus.unauthenticated ||
                            authState.status == AuthStatus.unknown ||
                            authState.resetStatus == ResetStatus.error) {
                          var errorMessage = 'Authentication failed.';
                          if (authState.errorMessage!
                              .contains('user-not-found')) {
                            errorMessage =
                                'There is no account associated with this email.';
                          } else if (authState.errorMessage!
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
                        } else if (authState.resetStatus ==
                            ResetStatus.loaded) {
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
                            const SizedBox(height: 25),
                            ProfileDetailRow(
                              label: 'Name',
                              content: name,
                              onChange: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                              onSubmit: (value) {
                                context.read<UserBloc>().add(
                                      UpdateUser(
                                        updateFirebase: true,
                                        user: userState.user.copyWith(
                                          name: value,
                                        ),
                                      ),
                                    );
                              },
                            ),
                            ProfileDetailRow(
                              label: 'Email',
                              content: userState.user.email,
                              isEditable: false,
                              onChange: (value) {},
                              onSubmit: (value) {},
                            ),
                            userState.user.email == 'anon@mous.ly'
                                ? const SizedBox()
                                : ProfileDetailRow(
                                    label: 'Password',
                                    content: userState.user.email,
                                    isEditable: false,
                                    isObscure: true,
                                    onChange: (value) {},
                                    onSubmit: (value) {},
                                    onPopup: () => showPasswordResetModal(
                                      context: context,
                                      email: userState.user.email,
                                    ),
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
                            context.read<AuthBloc>().add(
                                  SignOut(),
                                );
                          },
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ],
                  // ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong.'),
            );
          }
        },
      ),
    );
  }
}
