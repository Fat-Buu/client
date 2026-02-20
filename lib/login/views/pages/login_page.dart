import 'package:client/login/models/login_type_enum.dart';
import 'package:client/login/viewmodels/login_viewmodel.dart';
import 'package:client/login/views/widgets/button_login_widget.dart';
import 'package:client/login/views/widgets/header_section_widget.dart';
import 'package:client/login/views/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/profile_section_widget.dart' show ProfileSectionWidget;

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
          child: SingleChildScrollView(
            child: state.when(
              error: (err, st) => Text('Error: $err'),
              loading: () => CircularProgressIndicator(),
              data: (user) {
                final isLoggedIn = user.userName.isNotEmpty;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HeaderSectionWidget(
                      isLoggedIn: isLoggedIn,
                      name: user.userName,
                    ),
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
                      ProfileSectionWidget(
                        profileImage: user.profileImage,
                        onLogout: () {
                          ref.read(loginViewModelProvider.notifier).logout();
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        onGoToFeeds: () {
                          Navigator.pushReplacementNamed(context, '/feed');
                        },
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
