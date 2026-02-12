import 'package:client/login/views/pages/login_page.dart';
import 'package:flutter/material.dart';

class LoginWidgetTree extends StatelessWidget {
  const LoginWidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Application 2 - Client")),
      body: LoginPage(),
    );
  }
}
