import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(const MainApp());
// }

void main() {
  runApp(MaterialApp(
    home: RegistroPage(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final FilePickerResult? result =
                  await FilePicker.platform.pickFiles();

              if (result != null) {
                File file = File(result.files.single.path!);

                // Convertir el contenido del archivo en bytes
                // List<int> fileBytes = await file.readAsBytes();

                // Crear un objeto MultipartFile para enviar el archivo
                // var fileStream = http.ByteStream.fromBytes(fileBytes);
                // var length = await file.length();

                var fileStream = http.ByteStream(file.openRead());
                var length = await file.length();

                var request = http.MultipartRequest(
                  'POST',
                  Uri.parse('http://20.163.25.147:8000/newpost'),
                );

                request.headers['Authorization'] =
                    'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4IiwiZXhwIjoxNzEzNjU5NTI5fQ.4mcyBF4N05Cc7mQYNXl9dcFtg5k68xlE0JZmklMsTg8';
                print(request.headers);

                // Agregar el archivo al cuerpo de la solicitud
                request.files.add(
                  http.MultipartFile(
                    'file',
                    fileStream,
                    length,
                    filename: file.path.split('/').last,
                  ),
                );

                request.fields['title'] = 'new post with img';
                request.fields['content'] = 'img';

                // Enviar la solicitud y esperar la respuesta
                var response = await request.send();

                // Leer la respuesta como una cadena
                var responseBody = await response.stream.bytesToString();

                print(responseBody);
              } else {
                print("El usuario canceló la selección de archivo");
              }
            },
            child: Text('Press Me'),
          ),
        ),
      ),
    );
  }
}

class RegistroPage extends StatefulWidget {
  RegistroPage({Key? key}) : super(key: key);

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final TextEditingController _controllerUsername = TextEditingController();

  final TextEditingController _controllerCarrera = TextEditingController();

  final TextEditingController _controllerCorreo = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

  final TextEditingController _controllerAge = TextEditingController();

  final TextEditingController _controllerFile = TextEditingController();

  File? _image;

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
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Container(
                  padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
                  child: Image.asset(
                    'images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Usuario',
                  filled: true,
                  fillColor: const Color.fromARGB(142, 218, 104, 38),
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Karla',
                  ),
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                controller: _controllerUsername,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Karla',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Carrera',
                  filled: true,
                  fillColor: const Color.fromARGB(142, 218, 104, 38),
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Karla',
                  ),
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                controller: _controllerCarrera,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Karla',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Correo institucional',
                  filled: true,
                  fillColor: const Color.fromARGB(142, 218, 104, 38),
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Karla',
                  ),
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                controller: _controllerCorreo,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Karla',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  filled: true,
                  fillColor: const Color.fromARGB(142, 218, 104, 38),
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Karla',
                  ),
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                controller: _controllerPassword,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Karla',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Confirmar contraseña',
                  filled: true,
                  fillColor: const Color.fromARGB(142, 218, 104, 38),
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Karla',
                  ),
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                controller: _controllerConfirmPassword,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Karla',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Edad',
                  filled: true,
                  fillColor: const Color.fromARGB(142, 218, 104, 38),
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Karla',
                  ),
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                controller: _controllerAge,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Karla',
                ),
              ),
              SizedBox(height: 20),
              Padding(
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
                  ],
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  // Verifica si las contraseñas coinciden
                  if (_controllerPassword.text !=
                      _controllerConfirmPassword.text) {
                    // Muestra un diálogo de alerta si las contraseñas no coinciden
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error de contraseña'),
                          content: Text(
                              'Las contraseñas no coinciden. Por favor, inténtalo de nuevo.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Aceptar'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Si las contraseñas coinciden, realiza la solicitud de registro
                    print(_controllerAge.text);
                    print(_controllerUsername.text);
                    print(_controllerCarrera.text);
                    print(_controllerCorreo.text);
                    print(_controllerPassword.text);

                    // final response = await http.post(
                    //   Uri.parse('http://20.163.25.147:8000/users'),
                    //   body: {
                    //     'username': _controllerUsername.text,
                    //     'career': _controllerCarrera.text,
                    //     'email': _controllerCorreo.text,
                    //     'password': _controllerPassword.text,
                    //     // 'age': int.parse(_controllerAge.text),
                    //     'age': _controllerAge.text,
                    //     'file': _controllerFile.text,
                    //   },
                    final request = http.MultipartRequest(
                        'POST', Uri.parse('http://20.163.25.147:8000/users'));
                    request.files.add(await http.MultipartFile('file',
                        _image!.readAsBytes().asStream(), _image!.lengthSync(),
                        filename: _image!.path.split('/').last));
                    request.fields['username'] = _controllerUsername.text;
                    request.fields['career'] = _controllerCarrera.text;
                    request.fields['email'] = _controllerCorreo.text;
                    request.fields['password'] = _controllerPassword.text;
                    request.fields['age'] = _controllerAge.text;

                    final response = await request.send();
                    var responseBody = await response.stream.bytesToString();
                    print(responseBody);
                    if (response.statusCode == 200) {
                      // Manejo de la respuesta exitosa
                    }
                  }
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.resolveWith<Size>(
                    (states) {
                      if (states.contains(MaterialState.hovered)) {
                        return const Size(200, 60);
                      }
                      return const Size(180, 50);
                    },
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 217, 104, 38),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: const Text(
                  'REGISTRARME',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 15,
                    fontFamily: 'Karla',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
