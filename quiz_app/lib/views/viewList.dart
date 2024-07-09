import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/widgets/listUsers.dart';
import 'dart:convert' as convert;
import 'package:quiz_app/views/viewProfile.dart';
import 'package:get/get.dart';

class FetchFuture extends StatefulWidget {
  const FetchFuture({super.key});

  @override
  State<FetchFuture> createState() => _FetchFutureState();
}

class _FetchFutureState extends State<FetchFuture> {
  final String url = 'https://api.npoint.io/5cb393746e518d1d8880';

  Future<List> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      jsonResponse = jsonResponse['elementos'];
      print(jsonResponse);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
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
                    return ListUser(
                      image: snapshot.data![index]['urlImagen'],
                      name: snapshot.data![index]['nombreCompleto'],
                      career: snapshot.data![index]['profesion'],
                      uni: snapshot.data![index]['estudios'][0]['universidad']
                          .toString(),
                      functionButton: () {
                        final name =
                            snapshot.data![index]['nombreCompleto'].toString();
                        final career =
                            snapshot.data![index]['profesion'].toString();
                        final image =
                            snapshot.data![index]['urlImagen'].toString();
                        final uni = snapshot.data![index]['estudios'][0]
                                ['universidad']
                            .toString();
                        final age = snapshot.data![index]['edad'].toString();
                        final school = snapshot.data![index]['estudios'][0]
                                ['bachillerato']
                            .toString();
                        Get.to(UserProfile(
                          image: image,
                          name: name,
                          career: career,
                          uni: uni,
                          age: age,
                          school: school,
                        ));
                      },
                    );
                  },
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
