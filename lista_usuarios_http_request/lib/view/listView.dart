import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lista_usuarios_http_request/widgets/userList.dart';
import 'dart:convert' as convert;

class FetchFuture extends StatefulWidget {
  const FetchFuture({super.key});

  @override
  State<FetchFuture> createState() => _FetchFutureState();
}

class _FetchFutureState extends State<FetchFuture> {
  final String url = 'https://api.npoint.io/bffbb3b6b3ad5e711dd2';

  Future<List> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      jsonResponse = jsonResponse['items'];
      return jsonResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return UserList(
                    image: 'assets/img/${snapshot.data![index]['imagen']}',
                    name: snapshot.data![index]['nombre'],
                    career: snapshot.data![index]['carrera'],
                    avg: snapshot.data![index]['promedio'].toString(),
                  );
                },
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
