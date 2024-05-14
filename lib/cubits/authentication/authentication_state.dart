part of 'authentication_cubit.dart';

enum AuthenticationStatus {
  initial,
  submitting,
  success,
  error,
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final String email;
  final String name;
  final String password;
  final String? errorMessage;

  const AuthenticationState({
    required this.email,
    required this.name,
    required this.password,
    required this.status,
    this.errorMessage,
  });

  bool get isLoginValid => email != '' && password != '';

  bool get isRegisterValid => email != '' && name != '' && password != '';

  factory AuthenticationState.initial() {
    return const AuthenticationState(
      email: '',
      name: '',
      password: '',
      status: AuthenticationStatus.initial,
      // errorMessage: '',
    );
  }

  AuthenticationState copyWith({
    String? email,
    String? name,
    String? password,
    AuthenticationStatus? status,
    String? errorMessage,
  }) {
    return AuthenticationState(
      email: email ?? this.email,
      errorMessage: errorMessage ?? this.errorMessage,
      name: name ?? this.name,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        email,
        errorMessage,
        name,
        password,
        status,
      ];
}
