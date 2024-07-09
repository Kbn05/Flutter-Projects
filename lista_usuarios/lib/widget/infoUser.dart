import 'package:flutter/material.dart';

class InfoUser extends StatelessWidget {
  final String image;
  final String name;
  final String career;
  final double average;

  const InfoUser(
      {Key? key,
      required this.image,
      required this.name,
      required this.career,
      required this.average})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        color: const Color.fromARGB(255, 129, 129, 129),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              // Utiliza ClipRRect para redondear los bordes de la imagen
              borderRadius: BorderRadius.circular(
                  15.0), // Establece el radio de borde deseado
              child: Image.asset(image, width: 100, height: 100),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: $name'),
                  Text('Career: $career'),
                  Text('Average: $average'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
