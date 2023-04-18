import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/repositories/repositories.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  // final UserRepository _userRepository;

  AuthRepository({
    auth.FirebaseAuth? firebaseAuth,
    // required UserRepository userRepository,
  }) : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;
  // _userRepository = userRepository;

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<auth.User?> signUp({
    required User user,
    required String password,
    required String createdOn,
    required String lastLogin,
    required String deviceOS,
    required String deviceType,
    required String notificationToken,
  }) async {
    print('auth repo sign up');
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
        // )
        // .then(
        //   (value) => _userRepository.createUser(
        //     user.copyWith(
        //       id: value.user!.uid,
        //       createdOn: createdOn,
        //       lastLogin: lastLogin,
        //       deviceOS: deviceOS,
        //       deviceType: deviceType,
        //       notificationToken: notificationToken,
        //     ),
        //   ),
      );
      return null;
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  Future<auth.User?> signUpAnonymously({
    required User user,
    required String createdOn,
    required String lastLogin,
    required String deviceOS,
    required String deviceType,
    required String notificationToken,
  }) async {
    print('auth repo sign up anon');
    try {
      await _firebaseAuth.signInAnonymously();
      // await _firebaseAuth.signInAnonymously().then(
      //       (value) => _userRepository.createUser(
      //         user.copyWith(
      //           id: value.user!.uid,
      //           createdOn: createdOn,
      //           lastLogin: lastLogin,
      //           deviceOS: deviceOS,
      //           deviceType: deviceType,
      //           notificationToken: notificationToken,
      //         ),
      //       ),
      //     );
      return null;
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  Future<void> logInWithEmailAndPassword({
    required User user,
    required String email,
    required String password,
    required String lastLogin,
    required String notificationToken,
  }) async {
    print('auth repo login');
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        print('now updating..');
        // _userRepository.updateUser(
        //   user.copyWith(
        //     id: value.user!.uid,
        //     lastLogin: lastLogin,
        //     notificationToken: notificationToken,
        //   ),
        // );
        // print(user); // user is null at this moment
      });
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
  }) async {
    print('auth repo reset pass');
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email,
      );
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  Future<auth.User?> convertWithEmail({
    required User user,
    required String password,
  }) async {
    print('auth repo convert');
    final credential = auth.EmailAuthProvider.credential(
      email: user.email,
      password: password,
    );

    try {
      await _firebaseAuth.currentUser?.linkWithCredential(credential).then(
        (value) {
          // _userRepository.updateUser(
          //   user.copyWith(
          //     email: user.email,
          //   ),
          // );
        },
      );
      return null;
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  Future<void> signOut() async {
    print('auth sign out');
    await _firebaseAuth.signOut();
  }
}
