import 'package:client/core/database/database.dart';
import 'package:client/login/models/user.dart';

class LoginService {
  final Database _database;

  LoginService(this._database);

  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    List<User> users = _database.getAllUser();
    for (var user in users) {
      if (user.username == username && user.password == password) {
        return true;
      }
    }
    return false;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
