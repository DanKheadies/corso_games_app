part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
// class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent {
  final auth.User? authUser;
  // final UserStatus userStatus;

  const LoadUser(this.authUser);
  // const LoadUser({
  //   required this.authUser,
  //   required this.userStatus,
  // });

  @override
  List<Object?> get props => [
        authUser,
        // userStatus,
      ];
}

// class ToggleTheme extends UserEvent {
//   final bool userTheme;

//   const ToggleTheme({
//     required this.userTheme,
//   });

//   @override
//   List<Object> get props => [
//         userTheme,
//       ];
// }

class UpdateUser extends UserEvent {
  final User user;
  // final UserStatus userStatus;

  const UpdateUser({
    required this.user,
  });

  @override
  List<Object?> get props => [
        user,
        // userStatus,
      ];
}
