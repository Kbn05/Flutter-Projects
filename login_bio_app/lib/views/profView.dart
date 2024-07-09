import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:quiz_app/widgets/ratingWidget.dart';

class ProfView extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String? priceBefore;
  final String? discount;
  final String rateNum;
  final String score;
  final Widget rating;

  const ProfView(
      {Key? key,
      required this.image,
      required this.name,
      required this.price,
      required this.priceBefore,
      required this.discount,
      required this.rateNum,
      required this.score,
      required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      width: 350,
                      height: 500,
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              price,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            if (discount != '0')
                              Text(
                                '$discount',
                                style: TextStyle(
                                    color: discount == '0'
                                        ? Colors.red
                                        : Colors.green),
                              ),
                          ],
                        ),
                      ],
                    ),
                    // Text('Price: $price'),
                    // if (discount != '0')
                    //   Text(
                    //     '$discount',
                    //     style: TextStyle(
                    //         color: discount == '0' ? Colors.red : Colors.green),
                    //   ),
                    discount == '0'
                        ? Text('')
                        : Text('Price before: $priceBefore'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          rateNum,
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('$score votes'),
                              ],
                            ),
                            Row(
                              children: [
                                rating,
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Go back"))
                  ],
                )
              ],
            ))
          ],
        )),
      ),
    );
  }
}
