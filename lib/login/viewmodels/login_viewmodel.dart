import 'package:client/login/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/database/database.dart';
import '../services/login_service.dart';

part 'login_viewmodel.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  late LoginService _loginService;

  @override
  Future<User> build() async {
    _loginService = LoginService(Database());
    return User(username: "", password: "");
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final result = await _loginService.login(username, password);
      if (result) {
        state = AsyncValue.data(User(username: username, password: password));
      } else {
        state = AsyncValue.data(User(username: "", password: ""));
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await _loginService.logout();
      state = AsyncValue.data(User(username: "", password: ""));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// flutter pub run build_runner watch --delete-conflicting-outputs
