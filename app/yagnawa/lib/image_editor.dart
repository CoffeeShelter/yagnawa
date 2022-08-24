import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yagnawa/products.dart';

class ImageEditor extends StatelessWidget {
  final File image;

  const ImageEditor({
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.amber,
              width: size.width,
              height: size.height * 0.1,
              child: const Center(
                child: Text('상품명 입력 필드 추가'),
              ),
            ),
            Container(
              width: size.width,
              height: size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: FileImage(image),
                ),
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    width: size.width * 0.3,
                    child: IconButton(
                      tooltip: '뒤로가기',
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    width: size.width * 0.3,
                    child: IconButton(
                      tooltip: '전송하기',
                      icon: const Icon(Icons.arrow_forward_rounded),
                      onPressed: () {
                        getProductWithImage(
                          productName: '비타민',
                          image: image,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
