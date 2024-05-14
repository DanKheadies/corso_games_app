part of 'user_bloc.dart';

enum UserStatus {
  error,
  initial,
  loaded,
  loading,
}

class UserState extends Equatable {
  final User user;
  final UserStatus userStatus;

  const UserState({
    this.user = User.emptyUser,
    this.userStatus = UserStatus.initial,
  });

  @override
  List<Object> get props => [
        user,
        userStatus,
      ];

  UserState copyWith({
    User? user,
    UserStatus? userStatus,
  }) {
    return UserState(
      user: user ?? this.user,
      userStatus: userStatus ?? this.userStatus,
    );
  }

  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
      user: User.fromJson(json['user']),
      userStatus: UserStatus.values.firstWhere(
        (status) => status.name.toString() == json['userStatus'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(
          // isFirebase: false,
          ),
      'userStatus': userStatus.name,
    };
  }
}
