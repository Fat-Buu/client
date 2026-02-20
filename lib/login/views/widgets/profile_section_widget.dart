import 'package:flutter/material.dart';

class ProfileSectionWidget extends StatelessWidget {
  final String profileImage;
  final VoidCallback onLogout;
  final VoidCallback onGoToFeeds;

  const ProfileSectionWidget({
    super.key,
    required this.profileImage,
    required this.onLogout,
    required this.onGoToFeeds,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Image.asset(
            "assets/images/profiles/$profileImage",
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 150,
              width: 150,
              color: Colors.grey[300],
              child: const Icon(Icons.person, size: 80, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
          ),
          onPressed: onGoToFeeds,
          child: Text("Go to feeds"),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.redAccent,
            minimumSize: const Size.fromHeight(50),
          ),
          onPressed: onLogout,
          child: Text("Log out"),
        ),
      ],
    );
  }
}
