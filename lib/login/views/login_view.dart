import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/login_viewmodel.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = ref.watch(loginViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: AppBar(title: const Text("Application 2 - Client")),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (loginViewModel.username.isNotEmpty)
                  Text("Hi ${loginViewModel.username}"),
                const SizedBox(height: 16),
                Text("Login Form"),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: "username",
                    hintText: "Jason",
                    prefixIcon: Icon(Icons.cabin),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _obscurePassword = !_obscurePassword;
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    String username = usernameController.text;
                    String password = passwordController.text;
                    ref
                        .read(loginViewModelProvider.notifier)
                        .login(username, password);
                    setState(() {
                      usernameController.clear();
                      passwordController.clear();
                    });
                  },
                  child: const Text("Login"),
                ),
                const SizedBox(height: 8),
                Text("Register"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
