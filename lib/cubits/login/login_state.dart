// part of 'login_cubit.dart';

// enum LoginStatus {
//   initial,
//   submitting,
//   success,
//   reset,
//   resetting,
//   error,
// }

// class LoginState extends Equatable {
//   final String email;
//   final String password;
//   final LoginStatus status;
//   final String? errorMessage;
//   final auth.User? authUser;

//   bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

//   const LoginState({
//     required this.email,
//     required this.password,
//     required this.status,
//     this.errorMessage,
//     this.authUser,
//   });

//   factory LoginState.initial() {
//     return const LoginState(
//       email: '',
//       password: '',
//       status: LoginStatus.initial,
//       errorMessage: '',
//       authUser: null,
//     );
//   }

//   LoginState copyWith({
//     String? email,
//     String? password,
//     LoginStatus? status,
//     String? errorMessage,
//     auth.User? authUser,
//   }) {
//     return LoginState(
//       email: email ?? this.email,
//       password: password ?? this.password,
//       status: status ?? this.status,
//       errorMessage: errorMessage ?? this.errorMessage,
//       authUser: authUser ?? this.authUser,
//     );
//   }

//   @override
//   bool get stringify => true;

//   @override
//   List<Object?> get props => [
//         email,
//         password,
//         status,
//         errorMessage,
//         authUser,
//       ];
// }
