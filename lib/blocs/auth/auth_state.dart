part of 'auth_bloc.dart';

enum AuthStatus {
  authenticated,
  submitting,
  unauthenticated,
  unknown,
}

enum ResetStatus {
  error,
  initial,
  loaded,
  loading,
}

class AuthState extends Equatable {
  final auth.User? authUser;
  final AuthStatus status;
  final ResetStatus resetStatus;
  final String? errorMessage;

  const AuthState({
    this.authUser,
    this.errorMessage,
    this.resetStatus = ResetStatus.initial,
    this.status = AuthStatus.unknown,
  });

  @override
  List<Object?> get props => [
        authUser,
        errorMessage,
        resetStatus,
        status,
      ];

  AuthState copyWith({
    auth.User? authUser,
    AuthStatus? status,
    ResetStatus? resetStatus,
    String? errorMessage,
  }) {
    return AuthState(
      authUser: authUser ?? this.authUser,
      errorMessage: errorMessage ?? this.errorMessage,
      resetStatus: resetStatus ?? this.resetStatus,
      status: status ?? this.status,
    );
  }

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(
      errorMessage: json['errorMessage'],
      resetStatus: ResetStatus.values.firstWhere(
        (status) => status.name.toString() == json['resetStatus'],
      ),
      status: AuthStatus.values.firstWhere(
        (status) => status.name.toString() == json['status'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errorMessage': errorMessage,
      'resetStatus': resetStatus.name,
      'status': status.name,
    };
  }
}
