import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:file_picker/file_picker.dart';

class CrearEventoView extends StatefulWidget {
  @override
  _CrearEventoViewState createState() => _CrearEventoViewState();
}

class _CrearEventoViewState extends State<CrearEventoView> {
  File? _image;

  final TextEditingController _nombreEventoController = TextEditingController();
  final TextEditingController _ubicacionEventoController =
      TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _tipoEventoController = TextEditingController();
  final TextEditingController _fechaEventoController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Future getImage() async {
  //   final pickedFile =
  //       await ImagePicker().getImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Evento'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 211, 211, 211),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_image != null)
                          Image.file(
                            _image!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        if (_image == null)
                          Positioned.fill(
                            child: InkWell(
                              onTap: getImage,
                              child: Icon(Icons.add_a_photo, size: 50),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 8),

                //nombre del evento
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Nombre del Evento',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 211, 211, 211),
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _nombreEventoController,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                //ubicación del evento
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Ubicación del Evento',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 211, 211, 211),
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _ubicacionEventoController,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                //tipo de evento
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tipo de Evento',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        items: [
                          DropdownMenuItem(
                            child: Text('Deportivo'),
                            value: 'Deportivo',
                          ),
                          DropdownMenuItem(
                            child: Text('Cultural'),
                            value: 'Cultural',
                          ),
                          DropdownMenuItem(
                            child: Text('Académico'),
                            value: 'Académico',
                          ),
                          DropdownMenuItem(
                            child: Text('Entretenimiento'),
                            value: 'Entretenimiento',
                          ),
                          DropdownMenuItem(
                            child: Text('Otro'),
                            value: 'Otro',
                          ),
                          //
                        ],
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 211, 211, 211),
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                //dentro o fuera
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Dentro o Fuera',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        items: [
                          DropdownMenuItem(
                            child: Text('Dentro'),
                            value: 'Dentro',
                          ),
                          DropdownMenuItem(
                            child: Text('Fuera'),
                            value: 'Fuera',
                          ),
                        ],
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 211, 211, 211),
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                //descripción
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Descripción',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                        maxLines: 5,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 211, 211, 211),
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _descripcionController,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                //botones
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          //acción cancelar
                        },
                        icon: Icon(Icons.close, color: Colors.white),
                        label: Text('Cancelar',
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFD96826)),
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final SharedPreferences prefs = await _prefs;
                          final token = prefs.getString('token');
                          final request = http.MultipartRequest('POST',
                              Uri.parse('http://20.163.25.147:8000/newpost'));
                          request.headers['Authorization'] = 'Bearer $token';
                          request.files.add(await http.MultipartFile(
                              'file',
                              _image!.readAsBytes().asStream(),
                              _image!.lengthSync(),
                              filename: _image!.path.split('/').last));
                          request.fields['title'] =
                              _nombreEventoController.text;
                          request.fields['content'] =
                              _descripcionController.text;
                          request.fields['location'] =
                              _ubicacionEventoController.text;
                          request.fields['datetime'] =
                              _fechaEventoController.text;
                          request.fields['type_event'] =
                              _tipoEventoController.text;
                          final response = await request.send();
                          var responseBody =
                              await response.stream.bytesToString();
                          print(responseBody);
                          //   ..fields['title'] = _nombreEventoController.text
                          //   // ..fields['ubicacion'] = _ubicacionEventoController.text
                          //   ..fields['content'] = _descripcionController.text
                          //   ..files.add(await http.MultipartFile.fromPath(
                          //       'imagen', _image!.path));
                          // response.headers['Authorization'] = 'Bearer $token';
                          // final res = await response.send();
                          if (response.statusCode == 200) {
                            print('Evento creado');
                          }
                        },
                        icon: Icon(Icons.check, color: Colors.white),
                        label: Text('Guardar',
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF3F768B)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
