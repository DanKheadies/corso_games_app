import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';

import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/repositories/repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  StreamSubscription<auth.User?>? _authUserSubscription;
  // StreamSubscription<User?>? _userSubscription;

  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<AuthUserChanged>(_onAuthUserChanged);

    _authUserSubscription = _authRepository.user.listen((authUser) {
      print('auth bloc auth user sub');
      if (authUser != null) {
        print('auth bloc auth user sub - authUser not null');
        _userRepository.getUser(authUser.uid).listen((user) {
          print('auth bloc auth user sub - getUser');
          print(user); // have the user after the call to Firebase
          add(
            AuthUserChanged(
              authUser: authUser,
              user: user,
            ),
          );
        }).onError((err) {
          print('error: $err');
        });
      } else {
        print('auth bloc auth user sub - authUser null');
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
  ) {
    print('auth bloc auth user changed');
    // print(event.authUser);
    // print(event.user);

    // event.authUser != null
    //     ? emit(
    //         AuthState.authenticated(
    //           authUser: event.authUser!,
    //           user: event.user!,
    //         ),
    //       )
    //     : emit(
    //         const AuthState.unauthenticated(),
    //       );
    if (event.authUser != null) {
      print('is not null');
      emit(
        AuthState.authenticated(
          authUser: event.authUser!,
          user: event.user!,
        ),
      );
    } else {
      print('is null');
      emit(
        const AuthState.unauthenticated(),
      );
      // close();
    }
  }

  @override
  Future<void> close() {
    print('close?');
    _authUserSubscription?.cancel();
    // _userSubscription?.cancel();
    return super.close();
  }
}
