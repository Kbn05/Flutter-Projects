import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parcial_final/widgets/usersList.dart';

import 'dart:convert' as convert;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  Future<List> fetchProducts() async {
    final String? token = await storage.read(key: 'token');
    final response = await http
        .get(Uri.parse('http://10.153.82.75:3000/products/prod'), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await storage.delete(key: 'token');
              Get.offAllNamed('/');
            },
          ),
        ],
      ),
      body: FutureBuilder<List>(
        future: fetchProducts(),
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
                    return UsersList(
                      image: snapshot.data![index]['image'],
                      name: snapshot.data![index]['name'],
                      discount: snapshot.data![index]['discount'] > 0
                          ? '${snapshot.data![index]['discount']}% OFF'
                          : '0',
                      price: snapshot.data![index]['discount'] > 0
                          ? ((int.parse(snapshot.data![index]['price']) -
                                  (int.parse(snapshot.data![index]['price']) *
                                          snapshot.data![index]['discount']) /
                                      100))
                              .round()
                              .toString()
                          : snapshot.data![index]['price'],
                      priceBefore: snapshot.data![index]['price'],
                      rate: (double.parse(snapshot.data![index]['rate']) / 10)
                          .toString(),
                      score: snapshot.data![index]['score'],
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
