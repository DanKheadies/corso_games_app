import 'package:flutter/material.dart';

import 'package:corso_games_app/screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    // print('This is route: ${settings.name}');

    switch (settings.name) {
      case '/':
        // case SplashScreen.routeName:
        return SplashScreen.route();
      case ColorsSlideScreen.routeName:
        return ColorsSlideScreen.route();
      case CSSettingsScreen.routeName:
        return CSSettingsScreen.route();
      case DinoRunScreen.routeName:
        return DinoRunScreen.route();
      case ElWordScreen.routeName:
        return ElWordScreen.route();
      case GamesScreen.routeName:
        return GamesScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case MinesweeperScreen.routeName:
        return MinesweeperScreen.route();
      case MSSettingsScreen.routeName:
        return MSSettingsScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case PuzzlesAndDragginScreen.routeName:
        return PuzzlesAndDragginScreen.route();
      case RegistrationScreen.routeName:
        return RegistrationScreen.route();
      case SlideToSlideScreen.routeName:
        return SlideToSlideScreen.route();
      case SnakeScreen.routeName:
        return SnakeScreen.route();
      case SolitareScreen.routeName:
        return SolitareScreen.route();
      case SoloNobleScreen.routeName:
        return SoloNobleScreen.route();
      case TicTacToeScreen.routeName:
        return TicTacToeScreen.route();
      case WelcomeScreen.routeName:
        return WelcomeScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(
        name: '/error',
      ),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
      ),
    );
  }
}
