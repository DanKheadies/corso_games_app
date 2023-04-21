import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/repositories/repositories.dart';

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
      print('user bloc auth sub listening..');
      if (state.user != null) {
        print('user bloc auth sub - state has user');
        add(
          LoadUser(state.authUser),
        );
        //   // add(
        //   //   LoadUser(
        //   //     authUser: state.authUser!,
        //   //     userStatus: UserStatus.loading,
        //   //   ),
        //   // );
      }
    });
  }

  void _onLoadUser(
    LoadUser event,
    Emitter<UserState> emit,
  ) {
    print('user bloc load user');

    emit(
      UserLoading(),
    );

    if (event.authUser != null) {
      print('user bloc load user - event has authUser');
      _userRepository.getUser(event.authUser!.uid).listen((user) {
        print('user bloc load user getting User');
        add(
          UpdateUser(
            user: user,
          ),
        );
      });
    }
  }

  void _onUpdateUser(
    UpdateUser event,
    Emitter<UserState> emit,
  ) {
    print('user bloc update user');
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
