import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/widgets.dart';

class RegistrationScreen extends StatelessWidget {
  static const String routeName = '/registration';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const RegistrationScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.background,
            ),
            tooltip: 'Info Helper',
            onPressed: () => showScreenInfo(
              context,
              'Register',
              'Enter your email and a password.',
              false,
              TextAlign.center,
              'Let\'s Go',
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          Navigator.of(context).pop();
        },
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: const Registration(
        isAnon: false,
      ),
    );
  }
}
