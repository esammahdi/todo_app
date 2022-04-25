import 'package:hive/hive.dart';
import 'package:todo_app/model/user.dart';

class AuthenticationService {
  late Box<User> _users;
  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('usersBox');
    await _users.clear();
    await _users.add(User('Esam Mahdi', '1234'));
    await _users.add(User('Mahdi', '1234'));
    await _users.add(User('', ''));
  }

  Future<String?> authenticateUser(
      final String username, final String passwordHash) async {
    final success = _users.values.any((element) =>
        element.username == username && element.passwordHash == passwordHash);
    if (success) {
      return username;
    } else {
      return null;
    }
  }
}
