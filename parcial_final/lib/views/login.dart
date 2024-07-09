import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial_final/widgets/loginBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parcial_final/views/home.dart';
import 'package:parcial_final/views/signup.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> _loginUser() async {
    final response = await http.post(
      Uri.parse('http://192.168.20.20:8080/user'),
      body: {
        'username': _controllerUsername.text,
        'password': _controllerPassword.text,
      },
    );
    print('Response: ${response.body}');
    if (response.statusCode == 200) {
      await storage.write(key: 'token', value: response.body);
      Get.to(const Home());
      return response.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginBar(
              usernameController: _controllerUsername,
              passwordController: _controllerPassword,
            ),
            ElevatedButton(
              onPressed: () async {
                await _loginUser();
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
                onPressed: () async {
                  Get.to(SignUp());
                },
                child: const Text('Signup')),
          ],
        ),
      ),
    );
  }
}
