import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/games_drawer.dart';
import 'package:corso_games_app/widgets/screen_info.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({
    Key? key,
    required this.title,
    required this.infoTitle,
    required this.infoDetails,
    required this.children,
  }) : super(key: key);

  final String title;
  final String infoTitle;
  final String infoDetails;
  final Widget children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showScreenInfo(
              context,
              infoTitle,
              infoDetails,
            ),
          )
        ],
      ),
      drawer: const GamesDrawer(),
      body: children,
    );
  }
}
