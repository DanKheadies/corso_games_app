import 'package:corso_games_app/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthRepository _authRepository;

  AuthenticationCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthenticationState.initial());

  Future<bool> resetPassword({
    required String email,
  }) async {
    if (state.status == AuthenticationStatus.submitting) return false;

    emit(
      state.copyWith(
        status: AuthenticationStatus.submitting,
      ),
    );

    try {
      await _authRepository.resetPassword(email: email);

      emit(
        state.copyWith(
          status: AuthenticationStatus.success,
        ),
      );

      return true;
    } catch (err) {
      print('password reset err: $err');
      emit(
        state.copyWith(
          status: AuthenticationStatus.error,
          errorMessage: err.toString(),
        ),
      );
      return false;
    }
  }

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        status: AuthenticationStatus.initial,
      ),
    );
  }

  void nameChanged(String value) {
    emit(
      state.copyWith(
        name: value,
        status: AuthenticationStatus.initial,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: AuthenticationStatus.initial,
      ),
    );
  }

  void signOut() {
    emit(
      AuthenticationState.initial(),
    );
  }
}
