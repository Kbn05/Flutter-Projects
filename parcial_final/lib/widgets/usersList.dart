import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:login_bio_app/views/profView.dart';
import 'dart:ffi';

class UsersList extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String? priceBefore;
  final String? discount;
  final String rate;
  final String score;

  const UsersList(
      {Key? key,
      required this.image,
      required this.name,
      required this.price,
      required this.priceBefore,
      required this.discount,
      required this.rate,
      required this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(ProfView(
        //   image: image,
        //   name: name,
        //   price: price,
        //   priceBefore: priceBefore,
        //   discount: discount,
        //   rateNum: rate,
        //   score: score,
        // ));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          color: Color.fromARGB(255, 199, 199, 199),
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image(
                    image: NetworkImage(image),
                    width: 100,
                    height: 100,
                  )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name),
                    Row(
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
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
