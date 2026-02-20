import 'package:client/login/models/login_type_enum.dart';
import 'package:client/login/viewmodels/login_viewmodel.dart';
import 'package:client/login/views/widgets/button_login_widget.dart';
import 'package:client/login/views/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login(LoginTypeEnum type) {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    if (username.isEmpty || password.isEmpty) return;
    ref.read(loginViewModelProvider.notifier).login(username, password, type);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginViewModelProvider);
    final isLoading = state.isLoading;

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: state.when(
            data: (user) {
              final isLoggedIn = user.userName.isNotEmpty;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      isLoggedIn ? Icons.verified_user : Icons.android_outlined,
                      color: isLoggedIn ? Colors.green : Colors.grey,
                      size: 50,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isLoggedIn
                          ? "Hi ${user.firstName} ${user.lastName}"
                          : "Hi Guest",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    if (!isLoggedIn) ...[
                      const Text("Login Form"),
                      const SizedBox(height: 16),
                      TextFieldWidget(
                        labelText: "username",
                        controller: usernameController,
                        prefixIcon: const Icon(Icons.sailing_outlined),
                      ),
                      const SizedBox(height: 16),
                      TextFieldWidget(
                        labelText: "password",
                        controller: passwordController,
                        obscure: true,
                        prefixIcon: const Icon(Icons.lock),
                      ),
                      const SizedBox(height: 24),
                      ButtonLoginWidget(
                        labelText: 'Login with Flutter',
                        isLoading: isLoading,
                        onPressed: isLoading
                            ? null
                            : () => _login(LoginTypeEnum.flutter),
                      ),
                      const SizedBox(height: 8),
                      ButtonLoginWidget(
                        labelText: 'Login with Java',
                        isLoading: isLoading,
                        onPressed: isLoading
                            ? null
                            : () => _login(LoginTypeEnum.java),
                        gradientColors: [
                          Colors.greenAccent,
                          Colors.lightGreenAccent,
                        ],
                      ),
                      const SizedBox(height: 8),
                      ButtonLoginWidget(
                        labelText: 'Login with Python',
                        onPressed: null,
                        gradientColors: [
                          Colors.greenAccent,
                          Colors.lightGreenAccent,
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text("Register"),
                    ] else ...[
                      const SizedBox(height: 16),
                      Image.asset(
                        "assets/images/profiles/${user.profileImage}",
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/feed',
                            (route) => false,
                          );
                        },
                        child: Text("Go to feeds"),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(loginViewModelProvider.notifier).logout();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/',
                            (route) => false,
                          );
                        },
                        child: Text("Log out"),
                      ),
                    ],
                  ],
                ),
              );
            },
            error: (err, st) => Text('Error: $err'),
            loading: () => CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
