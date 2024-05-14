// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:corso_games_app/repositories/repositories.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart' as auth;
// import 'package:flutter/foundation.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';

// part 'sign_up_state.dart';

// class SignUpCubit extends Cubit<SignUpState> {
//   final AuthRepository _authRepository;

//   SignUpCubit({
//     required AuthRepository authRepository,
//   })  : _authRepository = authRepository,
//         super(SignUpState.initial());

//   void emailChanged(String value) {
//     emit(
//       state.copyWith(
//         email: value,
//         status: SignUpStatus.initial,
//       ),
//     );
//   }

//   void passwordChanged(String value) {
//     emit(
//       state.copyWith(
//         password: value,
//         status: SignUpStatus.initial,
//       ),
//     );
//   }

//   void signOut() {
//     emit(
//       SignUpState.initial(),
//     );
//   }

//   Future<void> signUpWithCredentials() async {
//     if (!state.isFormValid || state.status == SignUpStatus.submitting) return;

//     emit(
//       state.copyWith(
//         status: SignUpStatus.submitting,
//       ),
//     );

//     try {
//       // Note: not sure why working with DateTime & Timestamp have to be so hard
//       var createdOn = DateTime.now().toString();
//       // var notificationToken = await FirebaseMessaging.instance.getToken();

//       String deviceOS = '';
//       String deviceType = '';

//       if (Platform.isAndroid) {
//         var androidInfo = await DeviceInfoPlugin().androidInfo;
//         var release = androidInfo.version.release;
//         var sdkInt = androidInfo.version.sdkInt;
//         var manufacturer = androidInfo.manufacturer;
//         var model = androidInfo.model;
//         deviceOS = 'Android $release (SDK $sdkInt)';
//         deviceType = '$manufacturer $model';
//         // print('Android $release (SDK $sdkInt), $manufacturer $model');
//         // Android 9 (SDK 28), Xiaomi Redmi Note 7
//       }

//       if (Platform.isIOS) {
//         var iosInfo = await DeviceInfoPlugin().iosInfo;
//         var systemName = iosInfo.systemName;
//         var version = iosInfo.systemVersion;
//         var name = iosInfo.data['utsname']['nodename']; // iosInfo.name;
//         var model = iosInfo.model;
//         deviceOS = '$systemName $version';
//         deviceType = '$name\'s $model';
//         // print('$systemName $version, $name $model');
//         // iOS 13.1, iPhone 11 Pro Max iPhone
//       }

//       var authUser = await _authRepository.signUp(
//         email: state.email,
//         password: state.password,
//         createdOn: createdOn,
//         lastLogin: createdOn,
//         deviceOS: deviceOS,
//         deviceType: deviceType,
//         // notificationToken: notificationToken ?? '',
//         notificationToken: '',
//       );

//       emit(
//         state.copyWith(
//           status: SignUpStatus.success,
//           authUser: authUser,
//         ),
//       );
//     } catch (err) {
//       print('sign up cubit creds err: $err');
//       emit(
//         state.copyWith(
//           status: SignUpStatus.error,
//           errorMessage: err.toString(),
//         ),
//       );
//     }
//   }

//   Future<void> signUpAnonymously() async {
//     if (state.status == SignUpStatus.submitting) return;

//     emit(
//       state.copyWith(
//         status: SignUpStatus.submitting,
//       ),
//     );

//     try {
//       // Note: not sure why working with DateTime & Timestamp have to be so hard
//       var createdOn = DateTime.now().toString();
//       // var notificationToken = await FirebaseMessaging.instance.getToken();

//       String deviceOS = '';
//       String deviceType = '';

//       if (kIsWeb) {
//         var webInfo = await DeviceInfoPlugin().webBrowserInfo;
//         var browser = webInfo.browserName;
//         var language = webInfo.language;
//         var platform = webInfo.platform;
//         var product = webInfo.product;
//         deviceOS = 'Web $browser ($language)';
//         deviceType = '$platform - $product';
//       } else {
//         if (Platform.isAndroid) {
//           var androidInfo = await DeviceInfoPlugin().androidInfo;
//           var release = androidInfo.version.release;
//           var sdkInt = androidInfo.version.sdkInt;
//           var manufacturer = androidInfo.manufacturer;
//           var model = androidInfo.model;
//           deviceOS = 'Android $release (SDK $sdkInt)';
//           deviceType = '$manufacturer $model';
//           // print('Android $release (SDK $sdkInt), $manufacturer $model');
//           // Android 9 (SDK 28), Xiaomi Redmi Note 7
//         } else if (Platform.isIOS) {
//           var iosInfo = await DeviceInfoPlugin().iosInfo;
//           var systemName = iosInfo.systemName;
//           var version = iosInfo.systemVersion;
//           var name = iosInfo.data['utsname']['nodename']; // iosInfo.name;
//           var model = iosInfo.model;
//           deviceOS = '$systemName $version';
//           deviceType = '$name\'s $model';
//           // print('$systemName $version, $name $model');
//           // iOS 13.1, iPhone 11 Pro Max iPhone
//         } else if (Platform.isMacOS) {
//           var macInfo = await DeviceInfoPlugin().macOsInfo;
//           var release = macInfo.osRelease;
//           var version = macInfo.majorVersion;
//           var model = macInfo.model;
//           var name = macInfo.computerName;
//           deviceOS = 'Mac $release (Ver. $version)';
//           deviceType = '$name\'s $model';
//         } else {
//           print('not a registered system');
//         }
//       }

//       var authUser = await _authRepository.signUpAnonymously(
//         createdOn: createdOn,
//         lastLogin: createdOn,
//         deviceOS: deviceOS,
//         deviceType: deviceType,
//         // notificationToken: notificationToken ?? '',
//         notificationToken: '',
//       );

//       emit(
//         state.copyWith(
//           status: SignUpStatus.success,
//           authUser: authUser,
//         ),
//       );
//     } catch (err) {
//       print('sign up err: $err');
//       emit(
//         state.copyWith(
//           status: SignUpStatus.error,
//           errorMessage: err.toString(),
//         ),
//       );
//     }
//   }

//   Future<void> convertWithEmail() async {
//     if (state.status == SignUpStatus.submitting) return;

//     emit(
//       state.copyWith(
//         status: SignUpStatus.submitting,
//       ),
//     );

//     try {
//       var authUser = await _authRepository.convertWithEmail(
//         email: state.email,
//         password: state.password,
//       );

//       emit(
//         state.copyWith(
//           status: SignUpStatus.success,
//           authUser: authUser,
//         ),
//       );
//     } catch (err) {
//       print('sign up cubit convert err: $err');
//       emit(
//         state.copyWith(
//           status: SignUpStatus.error,
//           errorMessage: err.toString(),
//         ),
//       );
//     }
//   }
// }
