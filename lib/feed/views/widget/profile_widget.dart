import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String profileImage;

  const ProfileWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Image.asset("assets/images/profiles/$profileImage", width: 75),
          const SizedBox(width: 16),
          Text("Hi $firstName $lastName"),
        ],
      ),
    );
  }
}
