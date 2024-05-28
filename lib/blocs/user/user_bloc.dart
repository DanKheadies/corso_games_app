import 'package:corso_games_app/helpers/device_info_helper.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  final DatabaseRepository _databaseRepository;

  UserBloc({
    required DatabaseRepository databaseRepository,
  })  : _databaseRepository = databaseRepository,
        super(const UserState()) {
    on<ClearUser>(_onClearUser);
    on<UpdateUser>(_onUpdateUser);
  }

  void _onClearUser(
    ClearUser event,
    Emitter<UserState> emit,
  ) {
    emit(
      state.copyWith(
        user: User.emptyUser,
        userStatus: UserStatus.initial,
      ),
    );
  }

  void _onUpdateUser(
    UpdateUser event,
    Emitter<UserState> emit,
  ) async {
    User updatedUser = User.emptyUser;
    if (state.userStatus == UserStatus.loading) return;

    emit(
      state.copyWith(
        userStatus: UserStatus.loading,
      ),
    );

    Map<String, String> deviceInfo = await getDeviceInfoHelper();

    if (!event.accountCreation) {
      updatedUser = event.user.copyWith(
        deviceOS: deviceInfo['deviceOS'],
        deviceType: deviceInfo['deviceType'],
        updatedAt: DateTime.now(),
      );
    } else {
      updatedUser = event.user;
    }

    try {
      if (event.updateFirebase) {
        await _databaseRepository.updateUser(
          user: updatedUser,
        );
      }

      emit(
        state.copyWith(
          user: updatedUser,
          userStatus: UserStatus.loaded,
        ),
      );
    } catch (err) {
      print('update user error: $err');
      emit(
        state.copyWith(
          user: updatedUser,
          userStatus: UserStatus.error,
        ),
      );
    }
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toJson();
  }
}
