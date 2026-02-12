import 'package:flutter/material.dart';

class ButtonLoginWidget extends StatelessWidget {
  final String labelText;
  final Function()? callBack;
  final List<Color> gradientColors;

  const ButtonLoginWidget({
    super.key,
    required this.labelText,
    this.callBack,
    this.gradientColors = const [Colors.blue, Colors.greenAccent],
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: callBack,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(
            labelText,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
