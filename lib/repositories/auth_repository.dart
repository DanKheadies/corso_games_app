import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/repositories/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthRepository({
    auth.FirebaseAuth? firebaseAuth,
    required UserRepository userRepository,
  })  : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _userRepository = userRepository;

  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  Future<auth.User?> signUp({
    required String email,
    required String password,
    required String createdOn,
    required String lastLogin,
    required String deviceOS,
    required String deviceType,
    required String notificationToken,
  }) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then(
            (value) => _userRepository.createUser(
              User.empty.copyWith(
                id: value.user!.uid,
                email: email,
                createdOn: createdOn,
                lastLogin: lastLogin,
                deviceOS: deviceOS,
                deviceType: deviceType,
                notificationToken: notificationToken,
              ),
            ),
          );
      return null;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<auth.User?> signUpAnonymously({
    required String createdOn,
    required String lastLogin,
    required String deviceOS,
    required String deviceType,
    required String notificationToken,
  }) async {
    try {
      await _firebaseAuth.signInAnonymously().then(
            (value) => _userRepository.createUser(
              User.empty.copyWith(
                id: value.user!.uid,
                createdOn: createdOn,
                lastLogin: lastLogin,
                deviceOS: deviceOS,
                deviceType: deviceType,
                notificationToken: notificationToken,
              ),
            ),
          );
      return null;
    } catch (err) {
      print('auth repo anon sign up err: $err');
      throw Exception(err);
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email,
      );
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<auth.User?> convertWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = auth.EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    try {
      await _firebaseAuth.currentUser?.linkWithCredential(credential);
      return null;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
