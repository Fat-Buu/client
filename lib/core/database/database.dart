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
        lastName: "Dart",
        profileImage: "479477_ninja_avatar_samurai_warrior_icon.png"),
    User(id: Uuid().v1().toString(),
        userName: "batman",
        password: "batman",
        firstName: "batman",
        lastName: "Dart",
        profileImage: "4043232_avatar_batman_comics_hero_icon.png"),
    User(id: Uuid().v1().toString(),
        userName: "heisenberg",
        password: "heisenberg",
        firstName: "Heisenberg",
        lastName: "Dart",
        profileImage: "4043240_avatar_bad_breaking_chemisrty_heisenberg_icon.png"),
    User(id: Uuid().v1().toString(),
        userName: "ozzy",
        password: "ozzy",
        firstName: "Ozzy",
        lastName: "Dart",
        profileImage: "4043278_avatar_male_ozzy_rock_singer_icon.png"),
  ];
}
