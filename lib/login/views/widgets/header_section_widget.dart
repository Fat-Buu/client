import 'package:flutter/material.dart';

class HeaderSectionWidget extends StatelessWidget {
  final bool isLoggedIn;
  final String name;

  const HeaderSectionWidget({
    super.key,
    required this.isLoggedIn,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          isLoggedIn ? Icons.verified_user : Icons.android_outlined,
          color: isLoggedIn ? Colors.green : Colors.grey,
          size: 50,
        ),
        const SizedBox(height: 8),
        Text(
          isLoggedIn ? "Hi $name" : "Hi Guest",
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
