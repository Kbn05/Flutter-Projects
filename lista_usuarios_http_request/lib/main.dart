import 'package:flutter/material.dart';
import 'package:lista_usuarios_http_request/view/listView.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: FetchFuture(),
    ),
  ));
}
