import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(LoginState.initial());

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        status: LoginStatus.initial,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: LoginStatus.initial,
      ),
    );
  }

  void signOut() {
    emit(
      state.copyWith(
        status: LoginStatus.initial,
        errorMessage: '',
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (state.status == LoginStatus.submitting) return;

    emit(
      state.copyWith(
        status: LoginStatus.submitting,
      ),
    );

    try {
      var lastLogin = DateTime.now().toString();
      var notificationToken = await FirebaseMessaging.instance.getToken();

      await _authRepository.logInWithEmailAndPassword(
        user: state.cgUser!,
        email: state.email,
        password: state.password,
        lastLogin: lastLogin,
        notificationToken: notificationToken ?? '',
      );

      print('should be success');
      // print();

      emit(
        state.copyWith(
          status: LoginStatus.success,
        ),
      );
    } catch (err) {
      print('login failed');
      print(err);
      emit(
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: err.toString(),
        ),
      );
    }
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    if (state.status == LoginStatus.resetting) return;

    emit(
      state.copyWith(
        status: LoginStatus.resetting,
      ),
    );

    try {
      await _authRepository.resetPassword(email: email);

      emit(
        state.copyWith(
          status: LoginStatus.reset,
        ),
      );
    } catch (err) {
      print('reset failed');
      print(err);
      emit(
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: err.toString(),
        ),
      );
    }
  }

  // Future<void> logInWithGoogle() async {
  //   if (state.status == LoginStatus.submitting) return;
  //   emit(
  //     state.copyWith(
  //       status: LoginStatus.submitting,
  //     ),
  //   );
  //   try {
  //     await _authRepository.logInWithGoogle();

  //     emit(
  //       state.copyWith(
  //         status: LoginStatus.success,
  //       ),
  //     );
  //     // TODO: update UI by refreshing or navigating and/or snackbar
  //   } catch (_) {}
  // }
}
