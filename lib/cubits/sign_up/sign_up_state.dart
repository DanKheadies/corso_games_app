part of 'sign_up_cubit.dart';

enum SignUpStatus {
  initial,
  submitting,
  success,
  error,
}

class SignUpState extends Equatable {
  final String email;
  final String password;
  final SignUpStatus status;
  final String? errorMessage;
  final auth.User? authUser;

  const SignUpState({
    required this.email,
    required this.password,
    required this.status,
    this.errorMessage,
    this.authUser,
  });

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  factory SignUpState.initial() {
    return const SignUpState(
      email: '',
      password: '',
      status: SignUpStatus.initial,
      errorMessage: '',
      authUser: null,
    );
  }

  SignUpState copyWith({
    String? email,
    String? password,
    SignUpStatus? status,
    String? errorMessage,
    auth.User? authUser,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      authUser: authUser ?? this.authUser,
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
        authUser,
      ];
}
