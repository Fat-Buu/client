import 'package:flutter/material.dart';

class ButtonLoginWidget extends StatelessWidget {
  final String labelText;
  final VoidCallback? onPressed;
  final List<Color> gradientColors;
  final bool isLoading;
  final double height;

  const ButtonLoginWidget({
    super.key,
    required this.labelText,
    required this.onPressed,
    this.gradientColors = const [Colors.blue, Colors.greenAccent],
    this.isLoading = false,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;
    return SizedBox(
      width: double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: isDisabled
              ? LinearGradient(colors: [Colors.white38, Colors.white38])
              : LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  labelText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
