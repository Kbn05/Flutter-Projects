import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfile extends StatelessWidget {
  final String image;
  final String name;
  final String career;
  final String uni;
  final String age;
  final String school;

  const UserProfile(
      {Key? key,
      required this.image,
      required this.name,
      required this.career,
      required this.uni,
      required this.age,
      required this.school})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: Column(
          children: <Widget>[
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: NetworkImage(image),
                      width: 250,
                      height: 250,
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Name: $name',
                        style: const TextStyle(
                            fontSize: 16), // Define el tamaño de la fuente aquí
                      ),
                      Text(
                        'Career: $career',
                        style: const TextStyle(
                            fontSize: 16), // Define el tamaño de la fuente aquí
                      ),
                      Text(
                        'Age: $age',
                        style: const TextStyle(
                            fontSize: 16), // Define el tamaño de la fuente aquí
                      ),
                      Text(
                        'University: $uni',
                        style: const TextStyle(
                            fontSize: 16), // Define el tamaño de la fuente aquí
                      ),
                      Text(
                        'School: $school',
                        style: const TextStyle(
                            fontSize: 16), // Define el tamaño de la fuente aquí
                      ),
                      const SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Go back"),
                      )
                    ],
                  ),
                ),
              ],
            ))
          ],
        )),
      ),
    );
  }
}
