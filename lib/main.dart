import 'package:corso_games_app/screens/solitare_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/screens/screens.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const CorsoGames());
}

class CorsoGames extends StatelessWidget {
  const CorsoGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(ticker: const Ticker()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromARGB(255, 192, 65, 111),
            secondary: Colors.amber[50],
            tertiary: const Color.fromARGB(255, 245, 125, 129),
          ),
        ),
        initialRoute: SplashScreen.id,
        routes: {
          ColorsSlideScreen.id: (context) => const ColorsSlideScreen(),
          CSSettingsScreen.id: (context) => const CSSettingsScreen(),
          DinoRunScreen.id: (context) => const DinoRunScreen(),
          ElWordScreen.id: (context) => const ElWordScreen(),
          GamesScreen.id: (context) => const GamesScreen(),
          MinesweeperScreen.id: (context) => const MinesweeperScreen(),
          MSSettingsScreen.id: (context) => const MSSettingsScreen(),
          PuzzlesAndDragginScreen.id: (context) =>
              const PuzzlesAndDragginScreen(),
          SlideToSlideScreen.id: (context) => const SlideToSlideScreen(),
          SolitareScreen.id: (context) => const SolitareScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          TicTacToeScreen.id: (context) => const TicTacToeScreen(),
        },
      ),
    );
  }
}
