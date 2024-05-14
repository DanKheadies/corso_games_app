import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corso_games_app/models/models.dart';

class DatabaseRepository {
  final FirebaseFirestore _firebaseFirestore;

  DatabaseRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  /// Checks users collection and creates a user if it doesn't exist.
  Future<void> createUser({
    required User user,
  }) async {
    bool userExist =
        (await _firebaseFirestore.collection('users').doc(user.id).get())
            .exists;

    if (userExist) {
      print('user repo - error creating user');
      throw Exception('User repo - error creating user: user exists');
    } else {
      await _firebaseFirestore.collection('users').doc(user.id).set(
            user.toJson(
              isFirebase: true,
            ),
          );
    }
  }

  /// Get the user from Firebase.
  Future<User> getUser({
    required String userId,
  }) async {
    try {
      DocumentSnapshot snap =
          await _firebaseFirestore.collection('users').doc(userId).get();

      return User.fromJson(
        snap.data() as Map<String, dynamic>,
        id: snap.id,
      );
    } catch (err) {
      print('user repo - error getting user');
      throw Exception('User Repo - error getting user: $err');
    }
  }

  /// Updates the user's record.
  Future<void> updateUser({
    required User user,
  }) async {
    try {
      return _firebaseFirestore.collection('users').doc(user.id).update(
            user.toJson(
              isFirebase: true,
            ),
          );
    } catch (err) {
      print('user repo - error updating user');
      throw Exception('User repo - error updating user: $err');
    }
  }
}
