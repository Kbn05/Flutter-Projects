import 'package:flutter/material.dart';

class ListUser extends StatelessWidget {
  final String image;
  final String name;
  final String career;
  final String uni;
  final Function() functionButton;

  const ListUser({
    Key? key,
    required this.image,
    required this.name,
    required this.career,
    required this.uni,
    required this.functionButton})
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
              borderRadius: BorderRadius.circular(
                  15.0),
              child: Image(image: NetworkImage(image), width: 100, height: 100,)
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: $name'),
                  Text('Career: $career'),
                  Text('University: $uni'),
                  ElevatedButton(onPressed: functionButton, child: const Text("View profile"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}