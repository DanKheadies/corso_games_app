import 'dart:async';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthBloc _authBloc;
  final UserRepository _userRepository;
  StreamSubscription? _authSubscription;

  UserBloc({
    required AuthBloc authBloc,
    required UserRepository userRepository,
  })  : _authBloc = authBloc,
        _userRepository = userRepository,
        super(UserLoading()) {
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user != null) {
        add(
          LoadUser(state.authUser),
        );
      }
    });
  }

  void _onLoadUser(
    LoadUser event,
    Emitter<UserState> emit,
  ) {
    emit(UserLoading());

    if (event.authUser != null) {
      _userRepository.getUser(event.authUser!.uid).listen((user) {
        // print('here');
        add(
          UpdateUser(
            user: user,
          ),
        );
      }).onError((err) {
        // TODO: generating a lot of errors on sign out; related to user repo / stream
        print('user bloc error: $err');
        // throw Exception('user bloc exception: $err');
      });
    }
  }

  void _onUpdateUser(
    UpdateUser event,
    Emitter<UserState> emit,
  ) {
    _userRepository.updateUser(event.user);
    emit(
      UserLoaded(
        user: event.user,
      ),
    );
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}
