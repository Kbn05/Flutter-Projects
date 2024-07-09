import 'package:flutter/material.dart';
import 'package:routes_app/views/view1.dart';
import 'package:routes_app/views/view2.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: const View1(), routes: <String, WidgetBuilder>{
    '/view2': (BuildContext context) => const View2(),
  }));
}
