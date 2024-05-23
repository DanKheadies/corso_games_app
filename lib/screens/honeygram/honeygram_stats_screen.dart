// import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
// TODO: uncomment when we need a new boards.txt file
// import 'dart:html';

import 'package:corso_games_app/blocs/blocs.dart';
// import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HoneygramStatsScreen extends StatelessWidget {
  const HoneygramStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Honeygram Stats',
      bottomBar: const SizedBox(),
      hasAppBar: true,
      hasDrawer: false,
      infoTitle: 'Honeygram Stats',
      infoDetails: 'Coming soon.',
      screenFunction: (_) {},
      nav: 'honeygram',
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.userStatus == UserStatus.initial ||
              state.userStatus == UserStatus.loading) {
            return const CustomCenter(
              child: CircularProgressIndicator(),
            );
          }
          if (state.userStatus == UserStatus.loaded) {
            if (state.user.email == 'davidwcorso@gmail.com' && kIsWeb) {
              return CustomCenter(
                child: GameButton(
                  isIconic: false,
                  icon: Icons.abc,
                  onPress: () {
                    print('Disabled atm');
                    // TODO: uncomment when we need a new boards.txt file
                    // var hgbState = context.read<HoneygramBoardsCubit>().state;
                    // var boardsList = [];

                    // for (int i = 0; i < hgbState.honeygramBoards.length; i++) {
                    //   boardsList.add(hgbState.honeygramBoards[i].toJson());
                    // }
                    // var toJson = jsonEncode(boardsList);
                    // var blob = Blob([toJson], 'text/plain', 'native');

                    // AnchorElement(
                    //   href: Url.createObjectUrlFromBlob(blob).toString(),
                    // )
                    //   ..setAttribute("download", "precompiled-boards.txt")
                    //   ..click();
                  },
                  title: 'toJSON',
                ),
              );
            } else {
              return const CustomCenter(
                child: Text('Coming soon..'),
              );
            }
          } else {
            return const CustomCenter(
              child: Text('Something went wrong.'),
            );
          }
        },
      ),
    );
  }
}
