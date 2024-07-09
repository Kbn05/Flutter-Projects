import 'package:flutter/material.dart';
import 'dart:io';

class LoginBar extends StatefulWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Size size;
  LoginBar(
      {Key? key,
      required this.usernameController,
      required this.passwordController,
      this.size = const Size(150, 100)})
      : super(key: key);

  @override
  State<LoginBar> createState() => _LoginBarState();
}

class _LoginBarState extends State<LoginBar> {
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
                controller: widget.usernameController,
              ),
              const SizedBox(
                height: 100,
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
            ],
          ),
        ),
      ),
    );
  }
}
