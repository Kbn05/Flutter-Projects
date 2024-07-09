import 'package:flutter/material.dart';
import 'package:routes_app/widgets/botoncito.dart';
import 'package:routes_app/views/view2.dart';
import 'package:routes_app/views/view3.dart';
import 'package:get/get.dart';

class View1 extends StatefulWidget {
  const View1({super.key});

  @override
  State<View1> createState() => _View1State();
}

class _View1State extends State<View1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ruta 1'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyBoton(
                  onPressed: () {
                    setState(() {
                      final result = Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const View2()));
                      print(result);
                    });
                  },
                  view: const Text('Ir a View 2')),
              MyBoton(
                  onPressed: () {
                    setState(() {
                      final result = Navigator.pushNamed(context, '/view2');
                      print(result);
                    });
                  },
                  view: const Text('Ir a View 2')),
              MyBoton(
                  onPressed: () {
                    Get.to(const View3());
                  },
                  view: const Text('Ir a View 3')),
            ],
          ),
        ));
  }
}
