import 'package:flutter/material.dart';

import 'package:corso_games_app/screens/colors_slide_screen.dart';
import 'package:corso_games_app/screens/dino_run_screen.dart';
import 'package:corso_games_app/screens/games_screen.dart';
import 'package:corso_games_app/screens/minesweeper_screen.dart';
import 'package:corso_games_app/screens/nonograms_screen.dart';
import 'package:corso_games_app/screens/slide_to_slide_screen.dart';

class GamesDrawer extends StatefulWidget {
  const GamesDrawer({Key? key}) : super(key: key);

  @override
  State<GamesDrawer> createState() => _GamesDrawerState();
}

class _GamesDrawerState extends State<GamesDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              GamesScreen.id,
            ),
            child: const DrawerHeader(
              margin: EdgeInsets.only(
                bottom: 10,
                top: 35,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/corso-games-1.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: SizedBox(),
            ),
          ),
          // ListTile(
          //   title: Text(
          //     'Games',
          //     style: TextStyle(
          //       fontSize: 18,
          //       color: Theme.of(context).colorScheme.primary,
          //     ),
          //   ),
          //   onTap: () {
          //     Navigator.pushNamed(
          //       context,
          //       GamesScreen.id,
          //     );
          //   },
          // ),
          ListTile(
            title: Text(
              'Colors Slide',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                ColorsSlideScreen.id,
              );
            },
          ),
          ListTile(
            title: Text(
              'Dino Run',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                DinoRunScreen.id,
              );
            },
          ),
          ListTile(
            title: Text(
              'Minesweeper',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                MinesweeperScreen.id,
              );
            },
          ),
          ListTile(
            title: Text(
              'Nonograms',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                NonogramsScreen.id,
              );
            },
          ),
          ListTile(
            title: Text(
              'Slide to Slide',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                SlideToSlideScreen.id,
              );
            },
          ),
        ],
      ),
    );
  }
}
