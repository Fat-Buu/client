import 'package:client/feed/views/widget/profile_widget.dart';
import 'package:client/feed/views/widget/suggest_friend.dart';
import 'package:client/feed/views/widget/text_widget.dart';
import 'package:client/login/viewmodels/login_viewmodel.dart';
import 'package:client/login/viewmodels/providers/login_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedViewState();
}

class _FeedViewState extends ConsumerState<FeedPage> {
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
            icon: const Icon(Icons.chat),
            onPressed: () {
              const snackBar = SnackBar(content: TextWidget(txt: "Chat"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              const snackBar = SnackBar(content: TextWidget(txt: "Logout"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              ref.read(loginProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProfileWidget(
                firstName: loginState.value?.firstName ?? "",
                lastName: loginState.value?.lastName ?? "",
                profileImage: loginState.value?.profileImage ?? "",
              ),
              SizedBox(height: 8),
              TextWidget(txt: "Suggest Friends"),
              SuggestFriend(),
              SizedBox(height: 8),
              TextWidget(txt: "Feeds"),
              Placeholder(),
            ],
          ),
        ),
      ),
    );
  }
}
