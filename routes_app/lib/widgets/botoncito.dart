import 'package:flutter/material.dart';

class MyBoton extends StatelessWidget {
  final Function() onPressed;
  final Text? view;

  const MyBoton({
    Key? key,
    required this.onPressed,
    required this.view,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed(),
      child: Text('$view'),
    );
  }
}
