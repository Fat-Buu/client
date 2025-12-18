import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../login/viewmodels/login_viewmodel.dart';
import '../../login/viewmodels/providers/login_service_provider.dart';

class FeedView extends ConsumerStatefulWidget {
  const FeedView({super.key});

  @override
  ConsumerState<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends ConsumerState<FeedView> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = loginViewModelProvider(
      loginService: ref.read(loginServiceProvider),
    );
    // Auth guard
    ref.listen(loginProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user.userName.isEmpty) {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          }
        },
      );
    });

    final loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Application 2 - Client"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(loginProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: SafeArea(child: Column(children: [buildLayoutProfile(loginState)])),
    );
  }
}

Container buildLayoutProfile(loginState) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Row(
      children: [
        Image.asset(
          "assets/images/profiles/${loginState.value?.profileImage}",
          width: 75,
        ),
        const SizedBox(width: 16),
        Text("Hi ${loginState.value?.firstName} ${loginState.value?.lastName}"),
      ],
    ),
  );
}
