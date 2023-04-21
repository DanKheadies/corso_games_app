import 'package:corso_games_app/models/models.dart';

abstract class BaseUserRepository {
  Future<void> createUser(User user);
  Stream<User> getUser(String userId);
  Future<void> updateUser(User user);
}
