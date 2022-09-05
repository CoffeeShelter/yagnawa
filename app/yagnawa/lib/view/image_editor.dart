import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yagnawa/products.dart';
import '../constants.dart';

class ImageEditor extends StatelessWidget {
  final File image;
  final myController = TextEditingController();

  ImageEditor({
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String productName = '';

    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  top: 25,
                ),
                width: size.width,
                height: size.height * 0.1,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: yDefaultPadding,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: yDefaultPadding,
                  ),
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: SizedBox(
                    width: size.width * 0.67,
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        hintText: '삼품명을 입력해주세요',
                        hintStyle: TextStyle(
                          color: yDefaultGreen.withOpacity(0.5),
                          fontSize: 18.0,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        productName = value;

                        getProductWithImage(
                          productName: productName,
                          image: image,
                        );
                        // Get.toNamed('/products?productName=$value');
                        myController.clear();
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 5,
                ),
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
      ),
    );
  }
}
