import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_usuarios/widget/infoUser.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    String jsonString = await rootBundle.loadString('assets/db/listUsers.json');
    setState(() {
      users = json.decode(jsonString);
      for (int i = 0; i < users.length; i++) {
        users[i]['image'] = 'assets/img/${i + 1}.jpg';
      }
    });
  }
  // List users = [
  //   {
  //     "image": "assets/img/1.jpg",
  //     "name": "Burger",
  //     "carrer": "Cocina",
  //     "average": 4.5
  //   },
  //   {
  //     "image": "assets/img/2.jpg",
  //     "name": "Pizza",
  //     "carrer": "Cocina",
  //     "average": 4.5
  //   },
  //   {
  //     "image": "assets/img/3.jpg",
  //     "name": "Pasta",
  //     "carrer": "Cocina",
  //     "average": 4.5
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            for (var user in users)
              InfoUser(
                image: user['image'],
                name: user['name'],
                career: user['carrer'],
                average: user['average'],
              ),
          ],
        ),
      );
    }
  }
}

// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ListView.builder(
//           itemCount: users.length,
//           itemBuilder: (context, index) {
//             Map<String, dynamic> user = users[index];
//             return InfoUser(
//               image: user['image'],
//               name: user['name'],
//               career: user['carrer'],
//               average: user['average'],
//             );
//           },
//         ),
//       ),
//     );
//   }