import 'package:flutter/material.dart';
import 'package:routes_app/widgets/botoncito.dart';

class View2 extends StatefulWidget {
  const View2({super.key});

  @override
  State<View2> createState() => _View2State();
}

class _View2State extends State<View2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ruta 2'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyBoton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  view: const Text('Ir a View 1')),
            ],
          ),
        ));
  }
}
