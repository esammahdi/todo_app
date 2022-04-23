
import 'package:hive/hive.dart';
import 'package:todo_app/model/user.dart';

class AuthenticationService {

  late Box<User> _users;
  Future<void> int() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('usersBox');
  }

  Future<String?> authenticateUser(final String username,final String passwordHash) async {
    final success = _users.values.any((element) => element.username == username && element.passwordHash == passwordHash);
    if(success) {
      return username;
    }
    else {
      return null;
    }
  }
}