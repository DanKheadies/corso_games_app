import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({
    Key? key,
    required this.title,
    required this.infoTitle,
    required this.infoDetails,
    this.showGLHF,
    this.useSingleScroll,
    this.alignment,
    this.button,
    required this.backgroundOverride,
    required this.content,
    required this.screenFunction,
    required this.bottomBar,
    this.floatingButton,
    this.floatingButtonLoc,
  }) : super(key: key);

  final String title;
  final String infoTitle;
  final String infoDetails;
  final bool? showGLHF;
  final bool? useSingleScroll;
  final TextAlign? alignment;
  final String? button;
  final Color backgroundOverride;
  final Widget content;
  final Function(String) screenFunction;
  final Widget bottomBar;
  final Widget? floatingButton;
  final FloatingActionButtonLocation? floatingButtonLoc;

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  @override
  Widget build(BuildContext context) {
    // print('build screen wrapper');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline,
            ),
            onPressed: () => showScreenInfo(
              context,
              widget.infoTitle,
              widget.infoDetails,
              widget.showGLHF ?? false,
              widget.alignment ?? TextAlign.left,
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
                    context.read<BrightnessCubit>().toggleBrightness();
                  });
              // return InkWell(
              //   borderRadius: BorderRadius.circular(50),
              //   child: Icon(
              //     state == Brightness.dark ? Icons.dark_mode : Icons.light_mode,
              //     // Icons.light_mode,
              //     // size: 45,
              //     // color: Theme.of(context).colorScheme.primary,
              //   ),
              //   onTap: () {
              //     context.read<BrightnessCubit>().toggleBrightness();
              //   },
              // );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      backgroundColor: widget.backgroundOverride != Colors.transparent
          ? widget.backgroundOverride
          : Theme.of(context).scaffoldBackgroundColor,
      body: widget.useSingleScroll != null
          ? SingleChildScrollView(
              child: widget.content,
            )
          : widget.content,
      bottomNavigationBar: widget.bottomBar,
      drawer: GamesDrawer(
        handler: (String string) => widget.screenFunction(string),
      ),
      floatingActionButton: widget.floatingButton,
      floatingActionButtonLocation: widget.floatingButtonLoc,
    );
  }
}
