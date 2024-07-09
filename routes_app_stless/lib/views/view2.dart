import 'package:flutter/material.dart';
import 'package:routes_app_stless/widgets/botoncito.dart';

class View2 extends StatelessWidget {
  final String title;
  const View2(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(title),
            MyBoton(
                onPressed: () {
                  Navigator.pop(context, 'Mundo');
                },
                text: 'Regresar a View 1'),
          ],
        ),
      ),
    );
  }
}
