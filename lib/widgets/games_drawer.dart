import 'package:flutter/material.dart';

import 'package:corso_games_app/screens/colors_slide/colors_slide_screen.dart';
import 'package:corso_games_app/screens/dino_dash_screen.dart';
import 'package:corso_games_app/screens/el_word_screen.dart';
import 'package:corso_games_app/screens/games_screen.dart';
import 'package:corso_games_app/screens/minesweeper/minesweeper_screen.dart';
import 'package:corso_games_app/screens/nonograms_screen.dart';
import 'package:corso_games_app/screens/slide_to_slide/slide_to_slide_screen.dart';
import 'package:corso_games_app/screens/tic_tac_toe_screen.dart';

class GamesDrawer extends StatefulWidget {
  const GamesDrawer({
    Key? key,
    required this.handler,
  }) : super(key: key);

  final Function(String) handler;

  @override
  State<GamesDrawer> createState() => _GamesDrawerState();
}

class _GamesDrawerState extends State<GamesDrawer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.handler('drawerOpen'));
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.handler('drawerClose'));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onTap: () {
              widget.handler('drawerNavigate');
              Navigator.pushNamed(
                context,
                GamesScreen.id,
              );
            },
            child: const DrawerHeader(
              margin: EdgeInsets.only(
                bottom: 10,
                top: 35,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/main/corso-games-1.png'),
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
              widget.handler('drawerNavigate');
              Navigator.pushNamed(
                context,
                ColorsSlideScreen.id,
              );
            },
          ),
          ListTile(
            title: Text(
              'Dino Dash',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              widget.handler('drawerNavigate');
              Navigator.pushNamed(
                context,
                DinoRunScreen.id,
              );
            },
          ),
          ListTile(
            title: Text(
              'El Word',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              widget.handler('drawerNavigate');
              Navigator.pushNamed(
                context,
                ElWordScreen.id,
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
              widget.handler('drawerNavigate');
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
              widget.handler('drawerNavigate');
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
              widget.handler('drawerNavigate');
              Navigator.pushNamed(
                context,
                SlideToSlideScreen.id,
              );
            },
          ),
          ListTile(
            title: Text(
              'Tic Tac Toe',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              widget.handler('drawerNavigate');
              Navigator.pushNamed(
                context,
                TicTacToeScreen.id,
              );
            },
          ),
        ],
      ),
    );
  }
}
