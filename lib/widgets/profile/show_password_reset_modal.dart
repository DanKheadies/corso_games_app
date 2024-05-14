import 'package:corso_games_app/cubits/cubits.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showPasswordResetModal({
  required String email,
  BuildContext? context,
}) {
  showCupertinoDialog(
    context: context!,
    builder: (context) {
      return BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          return CupertinoAlertDialog(
            title: Text(
              'Password Reset',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            content: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 15,
              ),
              child: Text(
                'Corso Games uses Google Firebase to authenticate account information. If you would like to reset your password, do it below.',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.left,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              state.status == AuthenticationStatus.submitting
                  ? CupertinoDialogAction(
                      child: const CircularProgressIndicator(),
                      onPressed: () {},
                    )
                  : CupertinoDialogAction(
                      child: Text(
                        'Reset',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      onPressed: () async {
                        var scaff = ScaffoldMessenger.of(context);
                        var nav = Navigator.of(context);

                        bool isSuccess = await context
                            .read<AuthenticationCubit>()
                            .resetPassword(
                              email: email,
                            );

                        if (isSuccess) {
                          scaff
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please check your email for a reset link.',
                                ),
                              ),
                            );
                          nav.pop();
                        }
                      },
                    ),
            ],
          );
        },
      );
    },
  );
}
