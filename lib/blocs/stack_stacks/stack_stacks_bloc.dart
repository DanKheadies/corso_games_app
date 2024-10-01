import 'package:corso_games_app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'stack_stacks_event.dart';
part 'stack_stacks_state.dart';

class StackStacksBloc extends HydratedBloc<StackStacksEvent, StackStacksState> {
  StackStacksBloc() : super(const StackStacksState()) {
    on<StackStacksEvent>((event, emit) {});

    // TODO: generate a list of StacksStackWidget
  }

  @override
  StackStacksState? fromJson(Map<String, dynamic> json) {
    return StackStacksState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(StackStacksState state) {
    return state.toJson();
  }
}
