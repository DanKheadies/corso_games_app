import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/widgets.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({
    Key? key,
    required this.title,
    required this.infoTitle,
    required this.infoDetails,
    this.showGLHF,
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
    return Scaffold(
      backgroundColor: widget.backgroundOverride != Colors.transparent
          ? widget.backgroundOverride
          : Theme.of(context).scaffoldBackgroundColor,
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
        ],
      ),
      drawer: GamesDrawer(
        handler: (String string) => widget.screenFunction(string),
      ),
      body: widget.content,
      bottomNavigationBar: widget.bottomBar,
      floatingActionButton: widget.floatingButton,
      floatingActionButtonLocation: widget.floatingButtonLoc,
    );
  }
}
