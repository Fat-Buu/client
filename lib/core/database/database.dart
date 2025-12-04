import '../../login/models/user.dart';

class Database {
  Database._internal();

  static final Database _instance = Database._internal();

  factory Database() {
    return _instance;
  }

  List<User> getAllUser() {
    return _users;
  }

  final List<User> _users = [
    User(username: "john", password: "john"),
    User(username: "jame", password: "jame"),
    User(username: "mark", password: "mark3"),
  ];
}
