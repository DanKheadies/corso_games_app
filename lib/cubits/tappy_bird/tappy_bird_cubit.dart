import 'package:hydrated_bloc/hydrated_bloc.dart';

class TappyBirdCubit extends HydratedCubit<int> {
  TappyBirdCubit() : super(0);

  void updateScore(int newScore) {
    emit(state < newScore ? newScore : state);
  }

  @override
  int? fromJson(Map<String, dynamic> json) {
    return json['score'];
  }

  @override
  Map<String, dynamic>? toJson(int state) {
    return <String, int>{'score': state};
  }
}
