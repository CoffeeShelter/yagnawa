import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yagnawa/products.dart';

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
                          Future<Map<String, dynamic>> future;
                          future = getProductWithImage(
                            productName: '비타민',
                            image: image,
                          );

                          future.then((value) {
                            ProductList productList = ProductList.fromJson(
                                value['result']['products']);

                            print(
                                'result: ${productList.products[0].productName}');
                          }).catchError((error) {
                            print(error);
                          });
                          //Get.toNamed('/products?productName=$value');
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

class ImageEditorCanvas extends StatefulWidget {
  const ImageEditorCanvas({Key? key}) : super(key: key);

  @override
  State<ImageEditorCanvas> createState() => _ImageEditorCanvasState();
}

class _ImageEditorCanvasState extends State<ImageEditorCanvas> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomPaint(
          child: Container(),
          painter: MyCanvas(),
        ),
      ),
    );
  }
}

class MyCanvas extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var offset = Offset(size.width / 2, size.height / 2);

    print(offset);

    drawRectangle(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw true;
  }

  var W = 600.0;
  void drawRectangle(Canvas canvas, Offset offset) {
    var rect = Rect.fromCenter(center: offset, width: W, height: W);
    var border = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    canvas.drawRect(rect, border);
  }
}
