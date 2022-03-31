import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './screens/colors_slide_screen.dart';
import 'screens/colors_slide/cs_settings_screen.dart';
import './screens/dino_run_screen.dart';
import './screens/games_screen.dart';
import './screens/minesweeper_screen.dart';
import './screens/nonograms_screen.dart';
import './screens/slide_to_slide_screen.dart';
import './screens/splash_screen.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const CorsoGames());
}

class CorsoGames extends StatelessWidget {
  const CorsoGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        GamesScreen.id: (context) => const GamesScreen(),
        MinesweeperScreen.id: (context) => const MinesweeperScreen(),
        NonogramsScreen.id: (context) => const NonogramsScreen(),
        SlideToSlideScreen.id: (context) => const SlideToSlideScreen(),
        SplashScreen.id: (context) => const SplashScreen(),
      },
    );
  }
}
