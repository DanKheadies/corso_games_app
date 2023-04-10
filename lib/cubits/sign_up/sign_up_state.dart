part of 'sign_up_cubit.dart';

enum SignUpStatus {
  initial,
  submitting,
  success,
  error,
}

class SignUpState extends Equatable {
  final String password;
  final SignUpStatus status;
  final String? errorMessage;
  final auth.User? authUser;
  final User? user;

  bool get isFormValid => user!.email.isNotEmpty && password.isNotEmpty;

  const SignUpState({
    required this.password,
    required this.status,
    this.errorMessage,
    this.authUser,
    this.user,
  });

  factory SignUpState.initial() {
    return const SignUpState(
      password: '',
      status: SignUpStatus.initial,
      errorMessage: '',
      authUser: null,
      user: User(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        password,
        status,
        errorMessage,
        authUser,
        user,
      ];

  SignUpState copyWith({
    String? password,
    SignUpStatus? status,
    String? errorMessage,
    auth.User? authUser,
    User? user,
  }) {
    return SignUpState(
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      authUser: authUser ?? this.authUser,
      user: user ?? this.user,
    );
  }
}
