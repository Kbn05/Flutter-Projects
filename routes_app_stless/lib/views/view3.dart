import 'package:flutter/material.dart';
import 'package:routes_app_stless/widgets/botoncito.dart';
import 'package:get/get.dart';

class View3 extends StatelessWidget {
  const View3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View 3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // MyBoton(
            //     onPressed: () {
            //       Navigator.pop(context, 'Mundo');
            //     },
            //     text: 'Regresar a View 1')
            MyBoton(
                onPressed: () {
                  Get.back(result: 'Mundo');
                },
                text: 'Regresar a View 1')
          ],
        ),
      ),
    );
  }
}
