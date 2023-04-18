import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/repositories/repositories.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createUser(User user) async {
    print('user repo creating user');
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

  @override
  Stream<User> getUser(String userId) {
    print('user repo getUser');
    return _firebaseFirestore.collection('users').doc(userId).snapshots().map(
          (snap) => User.fromJson(
            snap.data() ?? {},
            snap.id,
          ),
        );
  }

  @override
  Future<void> updateUser(User user) async {
    print('user repo update');
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toJson());
  }
}
