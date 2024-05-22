import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class HoneygramWordsScreen extends StatelessWidget {
  const HoneygramWordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Honeygram Words',
      bottomBar: const SizedBox(),
      hasAppBar: true,
      hasDrawer: false,
      infoTitle: 'Honeygram Words',
      infoDetails: 'Here is the list of words for the current honeygram board.',
      screenFunction: (_) {},
      nav: 'honeygram',
      child: BlocBuilder<HoneygramBloc, HoneygramState>(
        builder: (context, state) {
          if (state.status != HoneygramStatus.error) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: state.board.validWords.length,
                itemBuilder: (context, index) {
                  return BlocBuilder<BrightnessCubit, Brightness>(
                    builder: (context, cubit) {
                      return ListTile(
                        title: Text(
                          state.board.validWords[index],
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
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
