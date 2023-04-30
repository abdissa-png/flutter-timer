import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  // final double? size;
  final VoidCallback onPressed;
  const ProductivityButton(
      {super.key,
      required this.color,
      required this.text,
      // this.size,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(this.text, style: TextStyle(color: Colors.white)),
      onPressed: this.onPressed,
      style: TextButton.styleFrom(
        backgroundColor: this.color,
      ),
    );
  }
}
