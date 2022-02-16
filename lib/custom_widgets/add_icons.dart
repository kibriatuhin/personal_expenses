import 'package:flutter/material.dart';

@immutable
class AddIcon extends StatelessWidget {
  final IconData iconData;
  const AddIcon({Key? key, required this.iconData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      size: 25,
      color: Colors.white,
    );
  }
}
