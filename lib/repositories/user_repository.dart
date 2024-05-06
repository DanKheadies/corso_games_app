import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corso_games_app/models/models.dart';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> createUser(User user) async {
    bool userExist =
        (await _firebaseFirestore.collection('users').doc(user.id).get())
            .exists;

    if (userExist) {
      return;
    } else {
      await _firebaseFirestore
          .collection('users')
          .doc(user.id)
          .set(user.toJson());
    }
  }

  Stream<User> getUser(String userId) {
    return _firebaseFirestore.collection('users').doc(userId).snapshots().map(
          (snap) => User.fromJson(
            snap.data() ?? {},
            snap.id,
          ),
        );
  }

  Future<void> updateUser(User user) async {
    // print('user repo - update user');
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toJson());
  }
}
