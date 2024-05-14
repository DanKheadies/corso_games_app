import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/config/config.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ScreenWrapper extends StatelessWidget {
  final bool hasAppBar;
  final bool hasDrawer;
  // final bool? hasBack;
  final bool? showGLHF;
  final bool? useSingleScroll;
  final Color? backgroundColor;
  // final FloatingActionButton? flactionButton;
  final FloatingActionButtonLocation? flactionButtonLoc;
  final Function(String) screenFunction;
  final List<Widget>? actions;
  final String infoTitle;
  final String infoDetails;
  final String screen;
  final String? button;
  final String? nav;
  final TextAlign? alignment;
  final Widget child;
  final Widget? bottomBar;
  final Widget? flactionButton;
  // final Widget? floatingButton;

  const ScreenWrapper({
    super.key,
    required this.bottomBar,
    required this.child,
    required this.infoDetails,
    required this.infoTitle,
    required this.screen,
    required this.screenFunction,
    this.actions,
    this.alignment,
    this.backgroundColor,
    this.button,
    this.flactionButton,
    this.flactionButtonLoc,
    this.hasAppBar = true,
    // this.hasBack = false,
    this.hasDrawer = true,
    this.nav = 'games',
    this.showGLHF,
    this.useSingleScroll,
  });

  @override
  Widget build(BuildContext context) {
    // print('build screen wrapper');
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        // print(state.status);
        // // String screen =
        // //     GoRouter.of(context).routeInformationProvider.value.uri.toString();
        // if (state.status == AuthStatus.authenticated
        //     // && screen != '/onboarding'
        //     ) {
        //   // print('auth\'d');
        //   context.goNamed('games');
        // } else if (state.status == AuthStatus.unauthenticated ||
        //     state.status == AuthStatus.unknown) {
        //   // print('not auth\'d');
        //   context.goNamed('welcome');
        //   // } else {
        //   //   print('is submitting..');
        // }
        print('screen wrapper lister');
        if (
            // state.authUser != null &&
            state.status == AuthStatus.authenticated) {
          if (context.read<NavCubit>().state != '/welcome') {
            // print('go to cache');
            await Future.delayed(const Duration(milliseconds: 300), () {
              goRouter.go(
                context.read<NavCubit>().state,
              );
            });
          } else {
            // print('go to arrivals');
            context.goNamed('games');
          }
        } else if (state.status == AuthStatus.unauthenticated ||
            state.status == AuthStatus.unknown) {
          // print('not auth\'d');
          context.goNamed('welcome');
          // } else {
          //   print('is submitting..');
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
      child: Title(
        title: screen,
        color: Colors.white,
        child: Scaffold(
          appBar: hasAppBar
              ? AppBar(
                  title: Text(
                    screen,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  actions: actions ??
                      [
                        IconButton(
                          icon: const Icon(
                            Icons.info_outline,
                          ),
                          onPressed: () => showScreenInfo(
                            context,
                            infoTitle,
                            infoDetails,
                            showGLHF ?? false,
                            alignment ?? TextAlign.left,
                            'GLHF',
                          ),
                        ),
                        BlocBuilder<BrightnessCubit, Brightness>(
                          builder: (context, state) {
                            return IconButton(
                                icon: Icon(
                                  state == Brightness.dark
                                      ? Icons.dark_mode
                                      : Icons.light_mode,
                                ),
                                onPressed: () {
                                  context
                                      .read<BrightnessCubit>()
                                      .toggleBrightness();
                                });
                          },
                        ),
                        const SizedBox(width: 10),
                      ],
                  leading: nav != 'games'
                      ? IconButton(
                          onPressed: () {
                            context.goNamed(nav!);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                        )
                      : null,
                )
              : null,
          backgroundColor:
              backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          body: useSingleScroll != null
              ? SingleChildScrollView(
                  child: child,
                )
              : child,
          bottomNavigationBar: bottomBar,
          drawer: hasDrawer
              ? GamesDrawer(
                  handler: (String string) => screenFunction(string),
                )
              : null,

          floatingActionButton: flactionButton, // ?? const SizedBox(),
          floatingActionButtonLocation: flactionButtonLoc,
          resizeToAvoidBottomInset: false, // TODO: needed?
        ),
      ),
    );
  }
}
