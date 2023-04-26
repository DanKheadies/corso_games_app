import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/repositories/repositories.dart';
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
            child: BlocBuilder<BrightnessCubit, Brightness>(
              builder: (context, state) {
                return DrawerHeader(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                    top: 35,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: state == Brightness.dark
                          ? const AssetImage(
                              'assets/images/main/corso-games-2.png')
                          : const AssetImage(
                              'assets/images/main/corso-games-1.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: const SizedBox(),
                );
              },
            ),
          ),
          // const SizedBox(height: 10),
          // BlocBuilder<BrightnessCubit, Brightness>(
          //   builder: (context, state) {
          //     return Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         InkWell(
          //           borderRadius: BorderRadius.circular(50),
          //           child: Icon(
          //             state == Brightness.dark
          //                 ? Icons.dark_mode
          //                 : Icons.light_mode,
          //             size: 45,
          //             color: Theme.of(context).colorScheme.primary,
          //           ),
          //           onTap: () {
          //             context.read<BrightnessCubit>().toggleBrightness();
          //           },
          //         ),
          //       ],
          //     );
          //   },
          // ),
          // const SizedBox(height: 10),
          ListTile(
            title: Text(
              'Colors Slide',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            leading: Icon(
              Icons.blur_linear_rounded,
              color: Theme.of(context).colorScheme.primary,
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
            leading: Icon(
              Icons.run_circle,
              color: Theme.of(context).colorScheme.primary,
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
            leading: Icon(
              Icons.abc,
              color: Theme.of(context).colorScheme.primary,
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
            leading: Icon(
              Icons.flag_rounded,
              color: Theme.of(context).colorScheme.primary,
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
            leading: Icon(
              Icons.drag_indicator,
              color: Theme.of(context).colorScheme.primary,
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
            leading: Icon(
              Icons.view_comfortable,
              color: Theme.of(context).colorScheme.primary,
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
            leading: Icon(
              Icons.stacked_bar_chart,
              color: Theme.of(context).colorScheme.primary,
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
            leading: Icon(
              Icons.grain_rounded,
              color: Theme.of(context).colorScheme.primary,
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
            leading: Icon(
              Icons.tag,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () {
              widget.handler('drawerNavigate');
              Navigator.of(context).pushNamed(
                TicTacToeScreen.routeName,
              );
            },
          ),
          const SizedBox(height: 25),
          ListTile(
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            leading: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                ProfileScreen.routeName,
              );
            },
          ),
          // const SizedBox(height: 15),
          // ListTile(
          //   title: Text(
          //     'Logout', // Profile
          //     style: TextStyle(
          //       fontSize: 18,
          //       color: Theme.of(context).colorScheme.primary,
          //     ),
          //   ),
          //   leading: Icon(
          //     Icons.person,
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          //   onTap: () {
          //     context.read<AuthRepository>().signOut();
          //     context.read<LoginCubit>().signOut();
          //     context.read<SignUpCubit>().signOut();
          //     Navigator.of(context).pushNamedAndRemoveUntil(
          //       SplashScreen.routeName,
          //       (route) => false,
          //     );
          //   },
          // ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
