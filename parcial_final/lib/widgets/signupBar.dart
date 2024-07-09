import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:parcial_final/views/home.dart';
import 'package:http/http.dart' as http;

class SignupBar extends StatefulWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController occupation = TextEditingController();
  final Size size;
  SignupBar(
      {Key? key,
      required this.nameController,
      required this.passwordController,
      required this.emailController,
      required this.phoneController,
      required this.occupation,
      this.size = const Size(100, 50)})
      : super(key: key);

  @override
  State<SignupBar> createState() => _SignupBarState();
}

class _SignupBarState extends State<SignupBar> {
  File? image;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: const OutlineInputBorder(),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: widget.size.height / 2,
                    horizontal: widget.size.width / 4,
                  ),
                ),
                textAlign: TextAlign.right,
                controller: widget.nameController,
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: widget.size.height /
                        2, // Divide entre 2 para centrar verticalmente
                    horizontal: widget.size.width /
                        4, // Divide entre 4 para centrar horizontalmente
                  ),
                ),
                textAlign: TextAlign.right,
                controller: widget.passwordController,
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: const OutlineInputBorder(),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: widget.size.height /
                        2, // Divide entre 2 para centrar verticalmente
                    horizontal: widget.size.width /
                        4, // Divide entre 4 para centrar horizontalmente
                  ),
                ),
                textAlign: TextAlign.right,
                controller: widget.emailController,
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  border: const OutlineInputBorder(),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: widget.size.height /
                        2, // Divide entre 2 para centrar verticalmente
                    horizontal: widget.size.width /
                        4, // Divide entre 4 para centrar horizontalmente
                  ),
                ),
                textAlign: TextAlign.right,
                controller: widget.phoneController,
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Occupation',
                  border: const OutlineInputBorder(),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: widget.size.height /
                        2, // Divide entre 2 para centrar verticalmente
                    horizontal: widget.size.width /
                        4, // Divide entre 4 para centrar horizontalmente
                  ),
                ),
                textAlign: TextAlign.right,
                controller: widget.occupation,
              ),
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
                            if (image != null)
                              Image.file(
                                image!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            if (image == null)
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
              ElevatedButton(
                  onPressed: () async {
                    String? token =
                        await FirebaseMessaging.instance.getToken();
                    final request = http.MultipartRequest(
                      'POST',
                      Uri.parse('http://192.168.20.20:8080/user'),
                    );
                    request.files.add(
                      await http.MultipartFile(
                        'photo',
                        image!.readAsBytes().asStream(),
                        image!.lengthSync(),
                        filename: image!.path.split('/').last,
                      ),
                    );
                    request.fields['name'] = widget.nameController.text;
                    request.fields['password'] = widget.passwordController.text;
                    request.fields['email'] = widget.emailController.text;
                    request.fields['phoneNumber'] = widget.phoneController.text;
                    request.fields['position'] = widget.occupation.text;
                    request.fields['fcmToken'] = token!;
                    final response = await request.send();
                    if (response.statusCode == 201) {
                      Get.to(const Home());
                    } else {
                      throw Exception('Failed to create user');
                    }
                  },
                  child: const Text('Sign up')),
            ],
          ),
        ),
      ),
    );
  }
}
