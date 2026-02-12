import 'package:client/login/viewmodels/login_viewmodel.dart';
import 'package:client/login/viewmodels/providers/login_service_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final loginViewModel = ref.watch(
      loginViewModelProvider(loginService: ref.read(loginServiceProvider)),
    );

    void loginWithFlutter() {
      final username = usernameController.text.trim();
      final password = passwordController.text.trim();
      usernameController.clear();
      passwordController.clear();
      ref
          .read(
            loginViewModelProvider(
              loginService: ref.read(loginServiceProvider),
            ).notifier,
          )
          .login(username, password);
    }

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: loginViewModel.when(
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
                    if (isLoggedIn) ...[
                      const SizedBox(height: 16),
                      Image.asset(
                        "assets/images/profiles/${user.profileImage}",
                      ),
                    ],
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
                        callBack: loginWithFlutter,
                      ),
                      const SizedBox(height: 8),
                      ButtonLoginWidget(
                        labelText: 'Login with Java',
                        callBack: null,
                        gradientColors: [
                          Colors.greenAccent,
                          Colors.lightGreenAccent,
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text("Register"),
                    ] else ...[
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
                          ref
                              .read(
                                loginViewModelProvider(
                                  loginService: ref.read(loginServiceProvider),
                                ).notifier,
                              )
                              .logout();
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
