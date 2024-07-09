import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final int numberOfStars;

  const RatingWidget({
    Key? key,
    required this.numberOfStars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        numberOfStars,
        (index) => const Icon(Icons.star, color: Colors.amber),
      ),
    );
  }
}
