import 'package:client/login/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/login_service.dart';

part 'login_viewmodel.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  late LoginService _loginService;

  @override
  User build() {
    _loginService = LoginService();
    return User(username: "", password: "");
  }

  Future<void> login(String username, String password) async {
    final result = await _loginService.login(username, password);
    if (result) {
      state = User(username: username, password: password);
    } else {
      state = User(username: "", password: "");
    }
  }
}

// flutter pub run build_runner watch --delete-conflicting-outputs
