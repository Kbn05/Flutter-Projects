import 'package:flutter/material.dart';

// enum ColorSelection { amarillo, azul, rojo, verde, naranja }

class SecondView extends StatefulWidget {
  const SecondView({super.key});

  @override
  State<SecondView> createState() => _SecondViewState();
}

class _SecondViewState extends State<SecondView> {
  // Color _colorSelection = Colors.transparent;
  String? _color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            _color != null ? Text('Color: $_color') : const Text(''),
            ElevatedButton(
              child: const Text('Show options'),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 400,
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Show options'),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _color = 'Naranja';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                              child: const Text('Naranja'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _color = 'Lila';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                              ),
                              child: const Text('Lila'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _color = 'Rojo';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Rojo'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Select'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
