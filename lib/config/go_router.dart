import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter = GoRouter(
  routes: [
    // case '/':
    //   // case SplashScreen.routeName:
    //   return SplashScreen.route();
    GoRoute(
      path: '/',
      name: 'splash',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SplashScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    ),
    // case ColorsSlideScreen.routeName:
    //   return ColorsSlideScreen.route();
    GoRoute(
      path: '/colorsSlide',
      name: 'colorsSlide',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ColorsSlideScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case CSSettingsScreen.routeName:
    //   return CSSettingsScreen.route();
    GoRoute(
      path: '/colorsSlideSettings',
      name: 'colorsSlideSettings',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const CSSettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case DinoRunScreen.routeName:
    //   return DinoRunScreen.route();
    GoRoute(
      path: '/dinoDash',
      name: 'dinoDash',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const DinoDashScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case ElSettingsScreen.routeName:
    //   return ElSettingsScreen.route();
    GoRoute(
      path: '/elWordSettings',
      name: 'elWordSettings',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ElSettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case ElWordScreen.routeName:
    //   return ElWordScreen.route();
    GoRoute(
      path: '/elWord',
      name: 'elWord',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ElWordScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case GamesScreen.routeName:
    //   return GamesScreen.route();
    GoRoute(
      path: '/games',
      name: 'games',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const GamesScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case MinesweeperScreen.routeName:
    //   return MinesweeperScreen.route();
    GoRoute(
      path: '/minesweeper',
      name: 'minesweeper',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const MinesweeperScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case MSSettingsScreen.routeName:
    //   return MSSettingsScreen.route();
    GoRoute(
      path: '/minesweeperSettings',
      name: 'minesweeperSettings',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const MSSettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case NumbersAndDragginScreen.routeName:
    //   return NumbersAndDragginScreen.route();
    GoRoute(
      path: '/numbersAndDraggin',
      name: 'numbersAndDraggin',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const NumbersAndDragginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case ProfileScreen.routeName:
    //   return ProfileScreen.route();
    GoRoute(
      path: '/profile',
      name: 'profile',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ProfileScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case PuzzlesAndDragginScreen.routeName:
    //   return PuzzlesAndDragginScreen.route();
    GoRoute(
      path: '/puzzlesAndDraggin',
      name: 'puzzlesAndDraggin',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PuzzlesAndDragginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case SlideToSlideScreen.routeName:
    //   return SlideToSlideScreen.route();
    GoRoute(
      path: '/slideToSlide',
      name: 'slideToSlide',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SlideToSlideScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case SnakeScreen.routeName:
    //   return SnakeScreen.route();
    GoRoute(
      path: '/snake',
      name: 'snake',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SnakeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case SnakeSettingsScreen.routeName:
    //   return SnakeSettingsScreen.route();
    GoRoute(
      path: '/snakeSettings',
      name: 'snakeSettings',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SnakeSettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case SolitareScreen.routeName:
    //   return SolitareScreen.route();
    GoRoute(
      path: '/solitare',
      name: 'solitare',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SolitareScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case SoloNobleScreen.routeName:
    //   return SoloNobleScreen.route();
    GoRoute(
      path: '/soloNoble',
      name: 'soloNoble',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SoloNobleScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case TappyBirdScreen.routeName:
    //   return TappyBirdScreen.route();
    GoRoute(
      path: '/tappyBird',
      name: 'tappyBird',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const TappyBirdScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case TicTacToeScreen.routeName:
    //   return TicTacToeScreen.route();
    GoRoute(
      path: '/ticTacToe',
      name: 'ticTacToe',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const TicTacToeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
    // case WelcomeScreen.routeName:
    //   return WelcomeScreen.route();
    // case LoginScreen.routeName:
    //   return LoginScreen.route();
    // case RegistrationScreen.routeName:
    //   return RegistrationScreen.route();
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const WelcomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      redirect: (context, state) => newRedirect(
        context,
        state,
      ),
    ),
  ],
  errorPageBuilder: (context, state) => CustomTransitionPage(
    key: state.pageKey,
    name: 'error',
    child: const ErrorScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
  ),
);

String newRedirect(
  BuildContext context,
  GoRouterState state,
) {
  print('is currently going to: ${state.uri}');

  if (state.uri.toString() != '/welcome') {
    context.read<NavCubit>().cacheLocation(state.uri.toString());
  }

  final bool isAuth =
      context.read<AuthBloc>().state.status == AuthStatus.authenticated;

  // Not authenticated
  if (!isAuth) {
    print('not authed, to welcome');
    return '/welcome';
  }

  // Auth & can skip welcome
  if (isAuth && state.uri.toString() == '/welcome') {
    print('auth\'d and going to games');
    return '/games';
  }

  print('to ${state.uri.toString()}');
  return state.uri.toString();
}