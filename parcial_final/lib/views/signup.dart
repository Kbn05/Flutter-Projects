import 'package:flutter/material.dart';
import 'package:parcial_final/widgets/signupBar.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerPosition = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SignupBar(
                  nameController: _controllerUsername,
                  passwordController: _controllerPassword,
                  emailController: _controllerEmail,
                  phoneController: _controllerPhone,
                  occupation: _controllerPosition,
                ),
              ],
            ),
          ),
        ));
  }
}
