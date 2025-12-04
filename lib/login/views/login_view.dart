import 'package:client/login/views/widgets/text_field_widget.dart';
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
            child: loginViewModel.when(
              data: (user) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Icon(
                        user.username.isNotEmpty ? Icons.verified_user : Icons
                            .android_outlined,
                        color: user.username.isNotEmpty ? Colors.green : Colors
                            .grey,),
                      const SizedBox(height: 8),
                      Text(user.username.isNotEmpty
                          ? "Hi ${user.username}"
                          : "Hi Guest"),
                      const SizedBox(height: 16),
                      if (user.username.isEmpty) ...[
                        Text("Login Form"),
                        TextFieldWidget(
                            labelText: "username",
                            controller: usernameController,
                            prefixIcon: Icon(Icons.sailing_outlined)),
                        const SizedBox(height: 16),
                        TextFieldWidget(
                            labelText: "password",
                            controller: passwordController, obscure: true,
                            prefixIcon: Icon(Icons.lock)),
                        const SizedBox(height: 24),
                        Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.blue, Colors.greenAccent],
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight),
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                String username = usernameController.text;
                                String password = passwordController.text;
                                setState(() {
                                  usernameController.clear();
                                  passwordController.clear();
                                });
                                ref
                                    .read(loginViewModelProvider.notifier)
                                    .login(username, password);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: const Text("Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text("Register"),
                      ] else
                        ...[
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(loginViewModelProvider.notifier)
                                  .logout();
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
      ),
    );
  }
}
