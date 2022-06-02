import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/timer/timer_bloc.dart';
import 'package:corso_games_app/models/ticker.dart';
import 'package:corso_games_app/screens/colors_slide/colors_slide_screen.dart';
import 'package:corso_games_app/screens/colors_slide/cs_settings_screen.dart';
import 'package:corso_games_app/screens/dino_dash_screen.dart';
import 'package:corso_games_app/screens/el_word/el_word_screen.dart';
import 'package:corso_games_app/screens/games_screen.dart';
import 'package:corso_games_app/screens/minesweeper/minesweeper_screen.dart';
import 'package:corso_games_app/screens/minesweeper/ms_settings_screen.dart';
import 'package:corso_games_app/screens/nonograms_screen.dart';
import 'package:corso_games_app/screens/slide_to_slide/slide_to_slide_screen.dart';
import 'package:corso_games_app/screens/splash_screen.dart';
import 'package:corso_games_app/screens/tic_tac_toe/tic_tac_toe_screen.dart';

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
          NonogramsScreen.id: (context) => const NonogramsScreen(),
          SlideToSlideScreen.id: (context) => const SlideToSlideScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          TicTacToeScreen.id: (context) => const TicTacToeScreen(),
        },
      ),
    );
  }
}
