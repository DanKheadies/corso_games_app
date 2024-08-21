import 'dart:async';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/helpers/device_info_helper.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthenticationCubit _authCubit;
  final AuthRepository _authRepository;
  final DatabaseRepository _databaseRepository;
  final UserBloc _userBloc;
  StreamSubscription<auth.User?>? _authUserSubscription;

  AuthBloc({
    required AuthenticationCubit authCubit,
    required AuthRepository authRepository,
    required DatabaseRepository databaseRepository,
    required UserBloc userBloc,
  })  : _authCubit = authCubit,
        _authRepository = authRepository,
        _databaseRepository = databaseRepository,
        _userBloc = userBloc,
        super(const AuthState()) {
    on<AuthUserChanged>(_onAuthUserChanged);
    on<LoginWithEmailAndPassword>(_onLoginWithEmailAndPassword);
    on<RegisterAnonymously>(_onRegisterAnonymously);
    on<RegisterWithEmailAndPassword>(_onRegisterWithEmailAndPassword);
    on<ResetError>(_onResetError);
    on<ResetPassword>(_onResetPassword);
    on<SignOut>(_onSignOut);

    // print('auth bloc start');
    _authUserSubscription = _authRepository.user.listen((authUser) {
      if (authUser != null) {
        // print('has auth user');
        add(
          AuthUserChanged(
            authUser: authUser,
          ),
        );
      }
    });
  }

  void _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    // print('auth user changed, is auth\'d');

    emit(
      state.copyWith(
        authUser: event.authUser,
        errorMessage: '',
        status: AuthStatus.authenticated,
      ),
    );
  }

  void _onLoginWithEmailAndPassword(
    LoginWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    // print('login w/ email pass');
    if (state.status == AuthStatus.submitting) {
      return;
    }

    emit(
      state.copyWith(
        status: AuthStatus.submitting,
      ),
    );

    try {
      var authUser = await _authRepository.loginWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      var user = await _databaseRepository.getUser(
        userId: authUser!.uid,
      );

      User updatedUser = user.copyWith(
        updatedAt: DateTime.now(),
      );

      _userBloc.add(
        UpdateUser(
          updateFirebase: true,
          user: updatedUser,
        ),
      );

      emit(
        state.copyWith(
          authUser: authUser,
          // cachedAuthUser: authUser,
          status: AuthStatus.authenticated,
        ),
      );
    } catch (err) {
      print('login (E&P) error: $err');
      // TODO: provide a better errorMessage
      emit(
        state.copyWith(
          authUser: null,
          // cachedAuthUser: null,
          errorMessage: err.toString(),
          status: AuthStatus.unauthenticated,
        ),
      );
    }
  }

  void _onRegisterAnonymously(
    RegisterAnonymously event,
    Emitter<AuthState> emit,
  ) async {
    if (state.status == AuthStatus.submitting) {
      return;
    }

    emit(
      state.copyWith(
        status: AuthStatus.submitting,
      ),
    );

    try {
      var authUser = await _authRepository.registerAnon();

      Map<String, String> deviceInfo = await getDeviceInfoHelper();

      _userBloc.add(
        UpdateUser(
          accountCreation: true,
          updateFirebase: false,
          user: User.emptyUser.copyWith(
            createdAt: authUser!.metadata.creationTime,
            deviceOS: deviceInfo['deviceOS'],
            deviceType: deviceInfo['deviceType'],
            email: 'anon@mous.ly',
            name: 'Anon',
            id: authUser.uid,
            updatedAt: authUser.metadata.creationTime,
          ),
        ),
      );

      emit(
        state.copyWith(
          authUser: authUser,
          // cachedAuthUser: authUser,
          status: AuthStatus.authenticated,
        ),
      );
    } catch (err) {
      print('register anon error: $err');
      emit(
        state.copyWith(
          authUser: null,
          // cachedAuthUser: null,
          errorMessage: err.toString(),
          status: AuthStatus.unauthenticated,
        ),
      );
    }
  }

  void _onRegisterWithEmailAndPassword(
    RegisterWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    if (state.status == AuthStatus.submitting) {
      return;
    }

    emit(
      state.copyWith(
        status: AuthStatus.submitting,
      ),
    );

    try {
      var authUser = await _authRepository.registerUser(
        email: event.email,
        name: event.name,
        password: event.password,
      );

      Map<String, String> deviceInfo = await getDeviceInfoHelper();

      _userBloc.add(
        UpdateUser(
          accountCreation: true,
          updateFirebase: false,
          user: User.emptyUser.copyWith(
            createdAt: authUser!.metadata.creationTime,
            deviceOS: deviceInfo['deviceOS'],
            deviceType: deviceInfo['deviceType'],
            email: event.email,
            name: event.name,
            id: authUser.uid,
            updatedAt: authUser.metadata.creationTime,
          ),
        ),
      );

      emit(
        state.copyWith(
          authUser: authUser,
          // cachedAuthUser: authUser,
          status: AuthStatus.authenticated,
        ),
      );
    } catch (err) {
      print('register error: $err');
      emit(
        state.copyWith(
          authUser: null,
          // cachedAuthUser: null,
          errorMessage: err.toString(),
          status: AuthStatus.unauthenticated,
        ),
      );
    }
  }

  void _onResetError(
    ResetError event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        errorMessage: '',
      ),
    );
  }

  void _onResetPassword(
    ResetPassword event,
    Emitter<AuthState> emit,
  ) async {
    if (state.resetStatus == ResetStatus.loading) return;

    emit(
      state.copyWith(
        resetStatus: ResetStatus.loading,
      ),
    );

    try {
      _authRepository.resetPassword(email: event.email);

      emit(
        state.copyWith(
          resetStatus: ResetStatus.loaded,
        ),
      );
    } catch (err) {
      print('reset error: $err');
      emit(
        state.copyWith(
          errorMessage: err.toString(),
          resetStatus: ResetStatus.loaded,
        ),
      );
    }
  }

  void _onSignOut(
    SignOut event,
    Emitter<AuthState> emit,
  ) {
    if (state.status == AuthStatus.submitting) {
      return;
    }

    emit(
      state.copyWith(
        status: AuthStatus.submitting,
      ),
    );

    try {
      _authRepository.signOut();

      _authCubit.signOut();

      _userBloc.add(
        ClearUser(),
      );

      emit(
        state.copyWith(
          authUser: null,
          // cachedAuthUser: null,
          errorMessage: '',
          status: AuthStatus.unauthenticated,
        ),
      );
    } catch (err) {
      print('sign out error: $err');
      emit(
        state.copyWith(
          authUser: null,
          // cachedAuthUser: null,
          errorMessage: err.toString(),
          status: AuthStatus.unauthenticated,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _authUserSubscription?.cancel();
    _authUserSubscription = null;
    return super.close();
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    // print('auth bloc fromJson');
    // print(json);
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    // print('auth bloc toJson');
    // print(state);
    return state.toJson();
  }
}
