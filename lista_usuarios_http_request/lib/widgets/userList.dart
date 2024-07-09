import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final String image;
  final String name;
  final String career;
  final String avg;

  const UserList(
      {Key? key,
      required this.image,
      required this.name,
      required this.career,
      required this.avg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        color: const Color.fromARGB(255, 138, 138, 138),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(image, width: 100, height: 100),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: $name'),
                  Text('Career: $career'),
                  Text('Average: $avg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
