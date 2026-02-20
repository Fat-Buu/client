import 'package:client/core/database/database.dart';
import 'package:client/login/services/login_java_service.dart';
import 'package:client/login/services/login_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = Provider((ref) => Database());

final loginServiceProvider = Provider(
  (ref) => LoginService(ref.read(databaseProvider)),
);

final loginJavaServiceProvider = Provider((ref) => LoginJavaService());
