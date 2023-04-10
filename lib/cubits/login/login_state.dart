part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  submitting,
  success,
  reset,
  resetting,
  error,
}

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final String? errorMessage;
  final auth.User? user;
  final User? cgUser;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  const LoginState({
    required this.email,
    required this.password,
    required this.status,
    this.errorMessage,
    this.user,
    this.cgUser,
  });

  factory LoginState.initial() {
    return const LoginState(
      email: '',
      password: '',
      status: LoginStatus.initial,
      errorMessage: '',
      user: null,
      cgUser: User(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        errorMessage,
        user,
        cgUser,
      ];

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? errorMessage,
    auth.User? user,
    User? cgUser,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      cgUser: cgUser ?? this.cgUser,
    );
  }
}
