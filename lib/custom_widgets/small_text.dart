import 'package:flutter/material.dart';
class SmallText extends StatelessWidget {
  final String text;

  SmallText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text, style: TextStyle(
      color: Colors.grey,
      fontSize: 14
    ),
    );
  }
}
