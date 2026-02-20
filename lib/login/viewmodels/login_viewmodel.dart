import 'package:client/login/models/login_type_enum.dart';
import 'package:client/login/models/user.dart';
import 'package:client/login/services/login_java_service.dart';
import 'package:client/login/viewmodels/providers/login_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/login_service.dart';

part 'login_viewmodel.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  late final LoginService _loginService = ref.read(loginServiceProvider);
  late final LoginJavaService _loginJavaService = ref.read(
    loginJavaServiceProvider,
  );

  @override
  Future<User> build() async {
    return _emptyUser;
  }

  Future<void> login(
    String username,
    String password,
    LoginTypeEnum loginType,
  ) async {
    _setLoading();
    try {
      final user = await _loginByType(username, password, loginType);
      state = AsyncValue.data(user);
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
  User get _emptyUser => User(
    id: '',
    userName: '',
    password: '',
    firstName: '',
    lastName: '',
    profileImage: '',
  );

  void _setLoading() => state = const AsyncValue.loading();

  void _setUser(User user) => state = AsyncValue.data(user);

  void _setError(Object e, StackTrace st) => state = AsyncValue.error(e, st);

  Future<User> _loginByType(
    String username,
    String password,
    LoginTypeEnum type,
  ) async {
    switch (type) {
      case LoginTypeEnum.flutter:
        return await _loginService.login(username, password) ?? _emptyUser;
      case LoginTypeEnum.java:
        return await _loginJavaService.login(username, password) ?? _emptyUser;
    }
  }
}

// dart run build_runner watch --delete-conflicting-outputs
