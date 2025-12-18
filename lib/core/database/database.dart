import 'package:uuid/uuid.dart';

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
    User(id: Uuid().v1().toString(),
        userName: "john",
        password: "john",
        firstName: "John",
        lastName: "Dart"),
    User(id: Uuid().v1().toString(),
        userName: "jame",
        password: "john",
        firstName: "John",
        lastName: "Dart"),
    User(id: Uuid().v1().toString(),
        userName: "max",
        password: "john",
        firstName: "John",
        lastName: "Dart"),
  ];
}
