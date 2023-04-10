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

// class UserBloc extends HydratedBloc<UserEvent, UserState> {
class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthBloc _authBloc;
  final UserRepository _userRepository;
  StreamSubscription? _authSubscription;

  // UserBloc({
  //   required AuthBloc authBloc,
  //   required UserRepository userRepository,
  // })  : _authBloc = authBloc,
  //       _userRepository = userRepository,
  //       super(UserLoading()) {
  //   on<LoadUser>(_onLoadUser);
  //   on<UpdateUser>(_onUpdateUser);
  UserBloc({
    required AuthBloc authBloc,
    required UserRepository userRepository,
  })  : _authBloc = authBloc,
        _userRepository = userRepository,
        // super(const UserState()) {
        super(UserLoading()) {
    on<LoadUser>(_onLoadUser);
    // on<ToggleTheme>(_onToggleTheme);
    on<UpdateUser>(_onUpdateUser);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user != null) {
        add(
          LoadUser(state.authUser),
        );
        // add(
        //   LoadUser(
        //     authUser: state.authUser!,
        //     userStatus: UserStatus.loading,
        //   ),
        // );
      }
    });
  }

  void _onLoadUser(
    LoadUser event,
    Emitter<UserState> emit,
  ) {
    // if (state.userStatus == UserStatus.loaded) return;

    emit(
      UserLoading(),
      // const UserState(
      //   user: User.empty,
      //   userStatus: UserStatus.loading,
      //   userTheme: false,
      // ),
      // UserState(
      //   user: state.user,
      //   userStatus: state.userStatus,
      //   userTheme: state.userTheme,
      // ),
    );

    if (event.authUser != null) {
      _userRepository.getUser(event.authUser!.uid).listen((user) {
        // add(
        //   // UpdateUser(
        //   //   user: user,
        //   // ),
        //   UserState(
        //     user: user,
        //   ),
        // );
        add(
          UpdateUser(
            user: user,
            // userStatus: UserStatus.loaded,
          ),
        );
      });
    } else {
      emit(
        UserUnauthenticated(),
      );
      // emit(
      //   const UserState(
      //     user: User.empty,
      //     userStatus: UserStatus.loading,
      //     userTheme: false,
      //   ),
      // );
    }
  }

  // void _onToggleTheme(
  //   ToggleTheme event,
  //   Emitter<UserState> emit,
  // ) {
  //   emit(
  //     UserState(
  //       user: state.user,
  //       userTheme: event.userTheme,
  //     ),
  //   );
  // }

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

  // @override
  // UserState? fromJson(Map<String, dynamic> json) {
  //   // TODO: implement fromJson
  //   throw UnimplementedError();
  // }

  // @override
  // Map<String, dynamic>? toJson(UserState state) {
  //   // TODO: implement toJson
  //   throw UnimplementedError();
  // }
}
