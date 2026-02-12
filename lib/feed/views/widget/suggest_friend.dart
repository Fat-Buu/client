import 'package:flutter/material.dart';

class SuggestFriend extends StatefulWidget {
  const SuggestFriend({super.key});

  @override
  State<SuggestFriend> createState() => _SuggestFriendState();
}

class _SuggestFriendState extends State<SuggestFriend> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var _ in [1, 2, 3, 4, 5])
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Information"),
                      content: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/profiles/samurai_man.png",
                            ),
                            SizedBox(height: 8),
                            Text("Samurai Man"),
                          ],
                        ),
                      ),
                      actions: [],
                    );
                  },
                );
              },
              child: Card(
                margin: EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/profiles/samurai_man.png",
                        width: 75,
                      ),
                      Text("Samurai Man"),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
