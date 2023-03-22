import 'package:flutter/material.dart';

import 'package:corso_games_app/screens/screens.dart';

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onTap: () {
              widget.handler('drawerNavigate');
              Navigator.pushNamed(
                context,
                GamesScreen.routeName,
              );
            },
            child: DrawerHeader(
              margin: const EdgeInsets.only(
                bottom: 10,
                top: 35,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? const AssetImage('assets/images/main/corso-games-2.png')
                      : const AssetImage(
                          'assets/images/main/corso-games-1.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: const SizedBox(),
            ),
          ),
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
                ColorsSlideScreen.routeName,
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
                DinoRunScreen.routeName,
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
                ElWordScreen.routeName,
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
                MinesweeperScreen.routeName,
              );
            },
          ),
          ListTile(
            title: Text(
              'Puzzles And Draggin',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              widget.handler('drawerNavigate');
              Navigator.pushNamed(
                context,
                PuzzlesAndDragginScreen.routeName,
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
                SlideToSlideScreen.routeName,
              );
            },
          ),
          ListTile(
            title: Text(
              'Solitare',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              widget.handler('drawerNavigate');
              Navigator.pushNamed(
                context,
                SolitareScreen.routeName,
              );
            },
          ),
          ListTile(
            title: Text(
              'Solo Noble',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              widget.handler('drawerNavigate');
              Navigator.pushNamed(
                context,
                SoloNobleScreen.routeName,
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
                TicTacToeScreen.routeName,
              );
            },
          ),
        ],
      ),
    );
  }
}
