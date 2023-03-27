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
        // final dataValues = settings.arguments as List;
        return CSSettingsScreen.route(
            // difficulty: dataValues[0],
            // timer: dataValues[1],
            );
      case DinoRunScreen.routeName:
        return DinoRunScreen.route();
      case ElWordScreen.routeName:
        return ElWordScreen.route();
      case GamesScreen.routeName:
        return GamesScreen.route();
      case MinesweeperScreen.routeName:
        return MinesweeperScreen.route();
      case MSSettingsScreen.routeName:
        final dataValues = settings.arguments as List;
        return MSSettingsScreen.route(
          difficulty: dataValues[0],
          timer: dataValues[1],
        );
      case PuzzlesAndDragginScreen.routeName:
        return PuzzlesAndDragginScreen.route();
      case SlideToSlideScreen.routeName:
        return SlideToSlideScreen.route();
      case SolitareScreen.routeName:
        return SolitareScreen.route();
      case SoloNobleScreen.routeName:
        return SoloNobleScreen.route();
      case TicTacToeScreen.routeName:
        return TicTacToeScreen.route();

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
