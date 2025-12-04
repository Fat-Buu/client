class LoginService {
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 3));
    return true;
  }
}
