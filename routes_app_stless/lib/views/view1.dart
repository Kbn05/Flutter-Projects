import 'package:flutter/material.dart';
import 'package:routes_app_stless/widgets/botoncito.dart';
import 'package:routes_app_stless/views/view2.dart';
import 'package:routes_app_stless/views/view3.dart';
import 'package:get/get.dart';

class View1 extends StatelessWidget {
  final String title = 'Hola';

  const View1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyBoton(
                onPressed: () async {
                  final result = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => View2(title)));
                  print('datos recibidos: $result');
                },
                text: 'Ir a View 2'),
            const SizedBox(height: 20),
            MyBoton(
                onPressed: () async {
                  final result = await Navigator.pushNamed(context, '/view2');
                  print('datos recibidos: $result');
                },
                text: 'Ir a View 2'),
            const SizedBox(height: 20),
            MyBoton(
                onPressed: () async {
                  final result = await Get.to(const View3());
                  print('datos recibidos: $result');
                },
                text: 'Ir a View 3'),
          ],
        ),
      ),
    );
  }
}
