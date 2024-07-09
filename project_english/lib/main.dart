import 'package:flutter/material.dart';
import 'lobby.dart';
import 'package:get/get.dart';
import 'agile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LobbyPage(),
    );
  }
}
