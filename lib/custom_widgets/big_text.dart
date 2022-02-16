import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  Color color;
  BigText({required this.text, this.color = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 17),
    );
  }
}
