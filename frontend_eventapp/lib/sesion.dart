import 'package:flutter/material.dart';
import 'package:frontend_eventapp/crear_evento.dart';

class Sesion extends StatelessWidget {
  const Sesion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi sesión', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 4, 61, 90),
      ),
      body: Container(
        color: const Color.fromARGB(255, 235, 224, 224),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Has iniciado sesión exitosamente!!!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Cerrar Sesión'),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CrearEventoView()),
                    );
                  },
                  child: const Text('Ver eventos')),
            ],
          ),
        ),
      ),
    );
  }
}
