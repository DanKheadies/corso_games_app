import 'package:hydrated_bloc/hydrated_bloc.dart';

// part 'nav_state.dart';

class NavCubit extends HydratedCubit<String> {
  NavCubit() : super('/welcome');

  void cacheLocation(String location) {
    emit(location);
  }

  @override
  String? fromJson(Map<String, dynamic> json) {
    return json['location'];
  }

  @override
  Map<String, dynamic>? toJson(String state) {
    return <String, String>{'location': state};
  }
}
