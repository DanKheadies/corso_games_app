import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:corso_games_app/models/models.dart';

part 'solitare_event.dart';
part 'solitare_state.dart';

class SolitareBloc extends HydratedBloc<SolitareEvent, SolitareState> {
  SolitareBloc() : super(const SolitareState()) {
    on<LoadSolitare>(_onLoadSolitare);
    on<ToggleSolitareReset>(_onToggleSolitareReset);
    on<TestSolitare>(_onTestSolitare);
    on<UpdateCards>(_onUpdateCards);
  }

  void _onLoadSolitare(
    LoadSolitare event,
    Emitter<SolitareState> emit,
  ) {
    if (state.solitareStatus == SolitareStatus.loaded) return;

    emit(
      const SolitareState(
        resetSolitare: false,
        test: 0,
        solitareStatus: SolitareStatus.loaded,
        allCards: [],
        cardColumn1: [],
        cardColumn2: [],
        cardColumn3: [],
        cardColumn4: [],
        cardColumn5: [],
        cardColumn6: [],
        cardColumn7: [],
        cardDeckClosed: [],
        cardDeckOpened: [],
        finalClubsDeck: [],
        finalDiamondsDeck: [],
        finalHeartsDeck: [],
        finalSpadesDeck: [],
      ),
    );
  }

  void _onToggleSolitareReset(
    ToggleSolitareReset event,
    Emitter<SolitareState> emit,
  ) {
    print('toggle solitare');
    emit(
      SolitareState(
        resetSolitare: !state.resetSolitare,
        test: state.test,
        solitareStatus: SolitareStatus.loaded,
        allCards: state.allCards,
        cardColumn1: state.cardColumn1,
        cardColumn2: state.cardColumn2,
        cardColumn3: state.cardColumn3,
        cardColumn4: state.cardColumn4,
        cardColumn5: state.cardColumn5,
        cardColumn6: state.cardColumn6,
        cardColumn7: state.cardColumn7,
        cardDeckClosed: state.cardDeckClosed,
        cardDeckOpened: state.cardDeckOpened,
        finalClubsDeck: state.finalClubsDeck,
        finalDiamondsDeck: state.finalDiamondsDeck,
        finalHeartsDeck: state.finalHeartsDeck,
        finalSpadesDeck: state.finalSpadesDeck,
      ),
    );
  }

  void _onTestSolitare(
    TestSolitare event,
    Emitter<SolitareState> emit,
  ) {
    print('test?');
    print(state.test);
    print(event.test);
    emit(
      SolitareState(
        resetSolitare: state.resetSolitare,
        test: event.test ?? state.test,
        solitareStatus: SolitareStatus.loaded,
        allCards: state.allCards,
        cardColumn1: state.cardColumn1,
        cardColumn2: state.cardColumn2,
        cardColumn3: state.cardColumn3,
        cardColumn4: state.cardColumn4,
        cardColumn5: state.cardColumn5,
        cardColumn6: state.cardColumn6,
        cardColumn7: state.cardColumn7,
        cardDeckClosed: state.cardDeckClosed,
        cardDeckOpened: state.cardDeckOpened,
        finalClubsDeck: state.finalClubsDeck,
        finalDiamondsDeck: state.finalDiamondsDeck,
        finalHeartsDeck: state.finalHeartsDeck,
        finalSpadesDeck: state.finalSpadesDeck,
      ),
    );
  }

  void _onUpdateCards(
    UpdateCards event,
    Emitter<SolitareState> emit,
  ) {
    print('updating');
    // print('all: ${event.allCards}');
    // print('c1: ${event.cardColumn1}');
    // print('c2: ${event.cardColumn2}');
    // print('c3: ${event.cardColumn3}');
    // print('c4: ${event.cardColumn4}');
    // print('c5: ${event.cardColumn5}');
    // print('c6: ${event.cardColumn6}');
    // print('c7: ${event.cardColumn7}');
    // print('closed: ${event.cardDeckClosed}');
    // print('opened: ${event.cardDeckOpened}');
    // print('clubs: ${event.finalClubsDeck}');
    // print('diamonds: ${event.finalDiamondsDeck}');
    // print('hearts: ${event.finalHeartsDeck}');
    // print('spades: ${event.finalSpadesDeck}');
    emit(
      SolitareState(
        resetSolitare: state.resetSolitare,
        test: DateTime.now().second,
        solitareStatus: state.solitareStatus,
        allCards: event.allCards ?? state.allCards,
        cardColumn1: event.cardColumn1 ?? state.cardColumn1,
        cardColumn2: event.cardColumn2 ?? state.cardColumn2,
        cardColumn3: event.cardColumn3 ?? state.cardColumn3,
        cardColumn4: event.cardColumn4 ?? state.cardColumn4,
        cardColumn5: event.cardColumn5 ?? state.cardColumn5,
        cardColumn6: event.cardColumn6 ?? state.cardColumn6,
        cardColumn7: event.cardColumn7 ?? state.cardColumn7,
        cardDeckClosed: event.cardDeckClosed ?? state.cardDeckClosed,
        cardDeckOpened: event.cardDeckOpened ?? state.cardDeckOpened,
        finalClubsDeck: event.finalClubsDeck ?? state.finalClubsDeck,
        finalDiamondsDeck: event.finalDiamondsDeck ?? state.finalDiamondsDeck,
        finalHeartsDeck: event.finalHeartsDeck ?? state.finalHeartsDeck,
        finalSpadesDeck: event.finalSpadesDeck ?? state.finalSpadesDeck,
      ),
    );
  }

  @override
  SolitareState? fromJson(Map<String, dynamic> json) {
    print('from');
    // print(json);
    // print(json['finalDiamondsDeck']);
    return SolitareState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SolitareState state) {
    print('solitare toJson');
    // print(state.cardColumn2);
    // print(state.cardDeckOpened);
    // print(state.finalDiamondsDeck);

    // print('reset: ${state.resetSolitare}');
    // print('status: ${state.solitareStatus}');
    // print('all: ${state.allCards}');
    // print('c1: ${state.cardColumn1}');
    // print('c2: ${state.cardColumn2}');
    // print('c3: ${state.cardColumn3}');
    // print('c4: ${state.cardColumn4}');
    // print('c5: ${state.cardColumn5}');
    // print('c6: ${state.cardColumn6}');
    // print('c7: ${state.cardColumn7}');
    // print('closed: ${state.cardDeckClosed}');
    // print('opened: ${state.cardDeckOpened}');
    // print('clubs: ${state.finalClubsDeck}');
    // print('diamonds: ${state.finalDiamondsDeck}');
    // print('hearts: ${state.finalHeartsDeck}');
    // print('spades: ${state.finalSpadesDeck}');

    return state.toJson();
  }
}
