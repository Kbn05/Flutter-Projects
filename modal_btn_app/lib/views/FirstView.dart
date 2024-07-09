import 'package:flutter/material.dart';

// enum ColorSelection { amarillo, azul, rojo, verde, naranja }

class FirstView extends StatefulWidget {
  const FirstView({super.key});

  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {
  Color _colorSelection = Colors.transparent;
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
                      color: Colors.blue,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Show options'),
                            ListTile(
                              title: const Text('Amarillo'),
                              leading: Radio<Color>(
                                value: Colors.yellow,
                                groupValue: _colorSelection,
                                onChanged: (Color? value) {
                                  setState(() {
                                    _colorSelection = value!;
                                    _color = 'Amarillo';
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Azul'),
                              leading: Radio<Color>(
                                value: Colors.blue,
                                groupValue: _colorSelection,
                                onChanged: (Color? value) {
                                  setState(() {
                                    _colorSelection = value!;
                                    _color = 'Azul';
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Rojo'),
                              leading: Radio<Color>(
                                value: Colors.red,
                                groupValue: _colorSelection,
                                onChanged: (Color? value) {
                                  setState(() {
                                    _colorSelection = value!;
                                    _color = 'Rojo';
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Verde'),
                              leading: Radio<Color>(
                                value: Colors.green,
                                groupValue: _colorSelection,
                                onChanged: (Color? value) {
                                  setState(() {
                                    _colorSelection = value!;
                                    _color = 'Verde';
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Naranja'),
                              leading: Radio<Color>(
                                value: Colors.orange,
                                groupValue: _colorSelection,
                                onChanged: (Color? value) {
                                  setState(() {
                                    _colorSelection = value!;
                                    _color = 'Naranja';
                                  });
                                },
                              ),
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
