import 'dart:async';

import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/repositories/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final DatabaseRepository _userRepository;

  AuthRepository({
    auth.FirebaseAuth? firebaseAuth,
    required DatabaseRepository userRepository,
  })  : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _userRepository = userRepository;

  /// Get Firebase's current user.
  auth.User? getUser() {
    try {
      final currentUser = _firebaseAuth.currentUser;
      return currentUser;
    } catch (err) {
      print('auth repo - get user err: $err');
      throw Exception(err);
    }
  }

  /// A stream for Firebase's user changes.
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  /// Authenticate with Firebase's email-password.
  Future<auth.User?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredentials.user;
    } catch (err) {
      print('login error: $err');
      String error = err.toString().split(']')[1].trimLeft();
      throw Exception(error);
    }
  }

  /// Registers the user with Firebase and creates a record in the users collections.
  Future<auth.User?> registerAnon() async {
    try {
      final userCredentials = await _firebaseAuth.signInAnonymously();

      await _userRepository.createUser(
        user: User.emptyUser.copyWith(
          createdAt: userCredentials.user!.metadata.creationTime,
          email: 'anon@mous.ly',
          id: userCredentials.user!.uid,
          name: 'Anon',
          updatedAt: userCredentials.user!.metadata.creationTime,
        ),
      );

      return userCredentials.user;
    } catch (err) {
      print('auth repo - register anon err: $err');
      throw Exception(err);
    }
  }

  /// Registers the user with Firebase and creates a record in the users collections.
  Future<auth.User?> registerUser({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final userCredentials =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _userRepository.createUser(
        user: User.emptyUser.copyWith(
          createdAt: userCredentials.user!.metadata.creationTime,
          email: email,
          id: userCredentials.user!.uid,
          name: name,
          updatedAt: userCredentials.user!.metadata.creationTime,
        ),
      );

      return userCredentials.user;
    } catch (err) {
      print('auth repo - register user err: $err');
      throw Exception(err);
    }
  }

  /// Reset Firebase password.
  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      print(email);
      await _firebaseAuth.sendPasswordResetEmail(
        email: email,
      );
    } catch (err) {
      print('auth repo - reset password err: $err');
      throw Exception(err);
    }
  }

  /// Sign out of Firebase's authentication.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
