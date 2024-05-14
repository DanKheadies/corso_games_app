import 'package:corso_games_app/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
              context.goNamed('games');
            },
            child: BlocBuilder<BrightnessCubit, Brightness>(
              builder: (context, state) {
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                    top: 40,
                  ),
                  height: 225,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Image(
                    image: AssetImage(
                      state == Brightness.dark
                          ? 'assets/images/main/corso-games-2.png'
                          : 'assets/images/main/corso-games-1.png',
                    ),
                  ),
                );
              },
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
            leading: Icon(
              Icons.blur_linear_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () {
              widget.handler('drawerNavigate');
              context.goNamed('colorsSlide');
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
              context.goNamed('dinoDash');
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
              context.goNamed('elWord');
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
              context.goNamed('minesweeper');
            },
          ),
          ListTile(
            title: Text(
              'Numbers And Draggin',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            leading: Icon(
              Icons.numbers,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () {
              widget.handler('drawerNavigate');
              context.goNamed('numbersAndDraggin');
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
              context.goNamed('puzzlesAndDraggin');
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
              context.goNamed('slideToSlide');
            },
          ),
          ListTile(
            title: Text(
              'Snake',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            leading: Icon(
              Icons.all_inclusive,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () {
              widget.handler('drawerNavigate');
              context.goNamed('snake');
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
              context.goNamed('solitare');
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
              context.goNamed('soloNoble');
            },
          ),
          ListTile(
            title: Text(
              'Tappy Bird',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            leading: Icon(
              Icons.airline_stops,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () {
              widget.handler('drawerNavigate');
              context.goNamed('tappyBird');
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
              context.goNamed('ticTacToe');
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
              context.goNamed('profile');
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
