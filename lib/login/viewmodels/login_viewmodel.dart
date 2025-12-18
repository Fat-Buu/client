import 'package:client/login/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/login_service.dart';

part 'login_viewmodel.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  late final LoginService _loginService;

  @override
  Future<User> build({required LoginService loginService}) async {
    _loginService = loginService;
    return _emptyUser;
  }

  Future<void> login(String username, String password) async {
    _setLoading();
    try {
      final result = await _loginService.login(username, password);
      _setUser(result ?? _emptyUser);
    } catch (e, st) {
      _setError(e, st);
    }
  }

  Future<void> logout() async {
    _setLoading();
    try {
      await _loginService.logout();
      _setUser(_emptyUser);
    } catch (e, st) {
      _setError(e, st);
    }
  }

  // --- Utils ---
  User get _emptyUser =>
      User(id: '', userName: '', password: '', firstName: '', lastName: '');

  void _setLoading() => state = const AsyncValue.loading();

  void _setUser(User user) => state = AsyncValue.data(user);

  void _setError(Object e, StackTrace st) => state = AsyncValue.error(e, st);
}

// flutter pub run build_runner watch --delete-conflicting-outputs
