import 'package:flutter/material.dart';

class MyBoton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const MyBoton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
