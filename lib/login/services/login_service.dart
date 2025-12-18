import 'package:client/core/database/database.dart';
import 'package:client/login/models/user.dart';
import 'package:logger/logger.dart';

class LoginService {
  final Database _database;
  final Logger _logger;

  LoginService(this._database, {
    Logger? logger,
  }) : _logger = logger ?? Logger(printer: PrettyPrinter());


  Future<User?> login(String username, String password) async {
    _logger.i('Login attempt: username=$username');
    await Future.delayed(const Duration(seconds: 1));
    List<User> users = _database.getAllUser();
    final user = users.cast<User?>().firstWhere((u) =>
    u!.userName == username && u.password == password, orElse: () => null,);
    if (user != null) {
      _logger.i('Login success: username=$username');
    } else {
      _logger.w('Login failed: username=$username');
    }
    return user;

  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
