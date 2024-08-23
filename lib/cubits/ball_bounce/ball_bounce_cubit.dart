import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'ball_bounce_state.dart';

class BallBounceCubit extends HydratedCubit<BallBounceState> {
  BallBounceCubit() : super(BallBounceState.initial());

  Future<int> derp() async {
    emit(
      state.copyWith(),
    );

    await Future.delayed(const Duration(milliseconds: 1500));

    emit(
      state.copyWith(),
    );

    return 0;
  }

  void gameOver() {
    emit(
      state.copyWith(
        status: BallBounceStatus.gameOver,
      ),
    );
  }

  void increaseScore() {
    int highScore = state.score + 1 > state.highestScore
        ? state.score + 1
        : state.highestScore;

    emit(
      state.copyWith(
        highestScore: highScore,
        score: state.score + 1,
      ),
    );
  }

  void reset() {
    emit(
      state.copyWith(
        score: 0,
      ),
    );
  }

  void setHighScore(int highScore) {
    emit(
      state.copyWith(
        highestScore: highScore,
      ),
    );
  }

  void setScore(int score) {
    emit(
      state.copyWith(
        score: score,
      ),
    );
  }

  @override
  BallBounceState? fromJson(Map<String, dynamic> json) {
    return BallBounceState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(BallBounceState state) {
    return state.toJson();
  }
}
