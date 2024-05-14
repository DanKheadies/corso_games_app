part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class ClearUser extends UserEvent {}

class UpdateUser extends UserEvent {
  final bool accountCreation;
  final bool updateFirebase;
  final User user;

  const UpdateUser({
    required this.updateFirebase,
    required this.user,
    this.accountCreation = false,
  });

  @override
  List<Object> get props => [
        accountCreation,
        updateFirebase,
        user,
      ];
}
