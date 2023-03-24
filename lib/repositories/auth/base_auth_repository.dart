import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:corso_games_app/models/models.dart';

abstract class BaseAuthRepository {
  Stream<auth.User?> get user;
  Future<auth.User?> signUp({
    required User user,
    required String password,
    required String createdOn,
    required String lastLogin,
    required String deviceOS,
    required String deviceType,
    required String notificationToken,
  });
  Future<auth.User?> signUpAnonymously({
    required User user,
    required String createdOn,
    required String lastLogin,
    required String deviceOS,
    required String deviceType,
    required String notificationToken,
  });
  Future<void> logInWithEmailAndPassword({
    required User user,
    required String email,
    required String password,
    required String lastLogin,
    required String notificationToken,
  });
  Future<void> resetPassword({
    required String email,
  });
  Future<auth.User?> convertWithEmail({
    required User user,
    required String password,
  });
  Future<void> signOut();
}
