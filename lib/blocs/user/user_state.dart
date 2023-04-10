part of 'user_bloc.dart';

// enum UserStatus {
//   unauthenticated,
//   loading,
//   loaded,
//   updated,
//   error,
// }

@immutable
abstract class UserState extends Equatable {
// class UserState extends Equatable {
  // final bool userTheme;
  // final User user;
  // final UserStatus userStatus;

  const UserState();
  // const UserState({
  //   this.userTheme = false,
  //   this.user = User.empty,
  //   this.userStatus = UserStatus.loading,
  // });

  // factory UserState.fromJson(Map<String, dynamic> json) {
  //   // User userTemp = User.users.first;
  //   return UserState(
  //     userTheme: json['userTheme'],
  //     user: json['user'],
  //     userStatus: json['userStatus'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'userTheme': userTheme,
  //     'user': user,
  //     'userStatus': userStatus,
  //   };
  // }

  @override
  List<Object> get props => [
        // userTheme,
        // user,
        // userStatus,
      ];
}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  const UserLoaded({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class UserUnauthenticated extends UserState {}
