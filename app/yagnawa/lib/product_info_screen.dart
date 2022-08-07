import 'package:flutter/material.dart';
import 'appbar.dart';

class ProductInfoScreen extends StatelessWidget {
  const ProductInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '고려은단 비타민C 1000 + 비타민D',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                '고려은단 헬스케어(주)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 1.5,
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(Icons.check),
                  ),
                  const Text(
                    '인증 현황',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    margin: const EdgeInsets.only(top: 5),
                    child: const Icon(Icons.ac_unit),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    margin: const EdgeInsets.only(top: 5),
                    child: const Icon(Icons.add_a_photo_outlined),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
