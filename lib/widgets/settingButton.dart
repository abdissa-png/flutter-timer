import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String, int);

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final int value;
  final String setting;
  final CallbackSetting callback;
  const SettingButton(
      {super.key,
      required this.color,
      required this.text,
      required this.value,
      required this.size,
      required this.setting,
      required this.callback});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: color, minimumSize: Size.fromWidth(size)),
      child: Text(text, style: TextStyle(fontSize: 24, color: Colors.white70)),
      onPressed: () => this.callback(this.setting, this.value),
    );
  }
}
