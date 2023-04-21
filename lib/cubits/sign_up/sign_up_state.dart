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
  // final User? user;

  // bool get isFormValid => user!.email.isNotEmpty && password.isNotEmpty;
  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  const SignUpState({
    required this.email,
    required this.password,
    required this.status,
    this.errorMessage,
    this.authUser,
    // this.user,
  });

  factory SignUpState.initial() {
    return const SignUpState(
      email: '',
      password: '',
      status: SignUpStatus.initial,
      errorMessage: '',
      authUser: null,
      // user: User(),
    );
  }

  SignUpState copyWith({
    String? email,
    String? password,
    SignUpStatus? status,
    String? errorMessage,
    auth.User? authUser,
    // User? user,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      authUser: authUser ?? this.authUser,
      // user: user ?? this.user,
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
        // user,
      ];
}
