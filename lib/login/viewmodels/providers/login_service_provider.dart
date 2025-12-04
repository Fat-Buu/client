import 'package:client/login/services/login_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database.dart';

final loginServiceProvider = Provider<LoginService>((ref) {
  final database = Database();
  return LoginService(database);
});
