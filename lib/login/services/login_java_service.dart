import 'dart:async';
import 'dart:convert';

import 'package:client/login/models/login_response.dart';
import 'package:client/login/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class LoginJavaService {
  static const String _baseUrl = 'http://192.168.2.42:8080';
  static const Duration _timeout = Duration(seconds: 5);
  final http.Client _client;
  final Logger _logger;

  LoginJavaService({http.Client? client, Logger? logger})
    : _client = client ?? http.Client(),
      _logger = logger ?? Logger(printer: PrettyPrinter());

  Future<User?> login(String username, String password) async {
    final uri = Uri.parse('$_baseUrl/api/auth/login');
    _logger.i('Login Java attempt: username=$username');
    try {
      const Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var body = jsonEncode(<String, String>{
        'username': username,
        'password': password,
      });
      final response = await _client
          .post(uri, headers: headers, body: body)
          .timeout(_timeout);
      return _handleResponse(response, password);
    } on TimeoutException {
      _logger.e('Login timeout');
      throw Exception('Connection timeout. Please try again.');
    } catch (e, st) {
      _logger.e('Login error', error: e, stackTrace: st);
      rethrow;
    }
  }

  User _handleResponse(http.Response response, String password) {
    _logger.i('Status code: ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> data = jsonDecode(response.body);
        LoginResponse loginResponse = LoginResponse.fromJson(data);
        _logger.i('Login success: ${loginResponse.username}');
        return User(
          id: loginResponse.jwtToken,
          userName: loginResponse.username,
          password: password,
          firstName: loginResponse.username,
          lastName: '',
          profileImage: 'assasin.png',
        );
      case 401:
        _logger.w('Unauthorized (401)');
        throw Exception('Invalid username or password');
      default:
        _logger.w('Server error: ${response.statusCode}');
        throw Exception('Server error: ${response.statusCode}');
    }
  }
}
