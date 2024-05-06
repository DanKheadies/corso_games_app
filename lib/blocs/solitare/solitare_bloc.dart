import 'package:corso_games_app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'solitare_event.dart';
part 'solitare_state.dart';

class SolitareBloc extends HydratedBloc<SolitareEvent, SolitareState> {
  SolitareBloc() : super(const SolitareState()) {
    on<LoadSolitare>(_onLoadSolitare);
    on<ToggleSolitareReset>(_onToggleSolitareReset);
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
        todoTicker: 0,
      ),
    );
  }

  void _onToggleSolitareReset(
    ToggleSolitareReset event,
    Emitter<SolitareState> emit,
  ) {
    emit(
      SolitareState(
        resetSolitare: !state.resetSolitare,
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
        todoTicker: state.todoTicker,
      ),
    );
  }

  void _onUpdateCards(
    UpdateCards event,
    Emitter<SolitareState> emit,
  ) {
    // TODO: Figure out why the state is already equal to the event here
    // Had to add the todoTicker to introduce new data so toJson would trigger
    emit(
      SolitareState(
        resetSolitare: state.resetSolitare,
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
        todoTicker: DateTime.now().second,
      ),
    );
  }

  @override
  SolitareState? fromJson(Map<String, dynamic> json) {
    return SolitareState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SolitareState state) {
    return state.toJson();
  }
}
