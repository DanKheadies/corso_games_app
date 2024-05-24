import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
// TODO: uncomment when we need a new boards.txt file
// import 'dart:html';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HoneygramStatsScreen extends StatelessWidget {
  const HoneygramStatsScreen({super.key});

  Future<void> resetHoneygram(BuildContext context) async {
    var hgCont = context.read<HoneygramBloc>();
    var hgbCont = context.read<HoneygramBoardsCubit>();
    var scaffCont = ScaffoldMessenger.of(context);

    scaffCont
      ..clearSnackBars()
      ..showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Honeygram is resetting..'),
        ),
      );

    await Future.delayed(const Duration(milliseconds: 500));

    final ByteData boardsBytes =
        await rootBundle.load('assets/data/honeygram/precompiled-boards.txt');
    final Uint8List boardsIntsList = boardsBytes.buffer.asUint8List();
    var boardsStringList = utf8.decode(boardsIntsList);
    var boardsJsonList = jsonDecode(boardsStringList);
    hgCont.add(
      ResetBoard(),
    );
    List<HoneygramBoard> honeygramBoards = await hgbCont.loadBoardsFromFile(
      data: boardsJsonList,
    );
    print('daco');
    print(honeygramBoards.length);
    hgCont.add(
      GetNewHoneygramBoard(
        honeygramBoards: honeygramBoards,
      ),
    );

    scaffCont
      ..clearSnackBars()
      ..showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Honeygram has reset!'),
        ),
      );
  }

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
                    resetHoneygram(context);
                    // print('Disabled atm');
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
                  title: 'Reset Honeygram',
                  // title: 'toJSON',
                ),
              );
            } else {
              return CustomCenter(
                child: GestureDetector(
                  onTap: () {
                    resetHoneygram(context);
                  },
                  child: const Text('Coming soon..'),
                ),
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
