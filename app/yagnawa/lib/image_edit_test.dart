import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yagnawa/products.dart';

var W = 100.0;
var startDx = 0.0;
var startDy = 0.0;
var endDx = 0.0;
var endDy = 0.0;
bool isClick = false;

var image = const AssetImage('assets/images/product01.jpg');
Image img = const Image(
  image: AssetImage('assets/images/product01.jpg'),
);

/*
void main() {
  runApp(const ImageEditor());
}
*/
class ImageEditor extends StatelessWidget {
  final File image;

  const ImageEditor({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Edit Test',
      home: ImageCanvas(image: image),
    );
  }
}

class ImageCanvas extends StatefulWidget {
  final File image;
  const ImageCanvas({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<ImageCanvas> createState() => _ImageCanvasState();
}

class _ImageCanvasState extends State<ImageCanvas> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 에디터 테스트'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: ImageDrawing(),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 30.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  BackButton(size),
                  SendButton(size),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container SendButton(Size size) {
    return Container(
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
            image: widget.image,
          );

          future.then((value) {
            ProductList productList =
                ProductList.fromJson(value['result']['products']);

            print('result: ${productList.products[0].productName}');
          }).catchError((error) {
            print(error);
          });
          //Get.toNamed('/products?productName=$value');
        },
      ),
    );
  }

  Container BackButton(Size size) {
    return Container(
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
    );
  }

  GestureDetector ImageDrawing() {
    return GestureDetector(
      child: CustomPaint(
        foregroundPainter: MyCanvas(),
        child: img,
      ),
      onHorizontalDragDown: (details) {
        setState(
          () {
            isClick = true;

            startDx = 0.0;
            startDy = 0.0;
            endDx = 0.0;
            endDy = 0.0;

            startDx = details.localPosition.dx;
            startDy = details.localPosition.dy;
            endDx = details.localPosition.dx;
            endDy = details.localPosition.dy;
          },
        );
      },
      onHorizontalDragEnd: (details) {
        setState(
          () {
            isClick = false;
          },
        );
      },
      onHorizontalDragUpdate: (details) {
        if (isClick) {
          setState(() {
            endDx = details.localPosition.dx;
            endDy = details.localPosition.dy;
          });
        }
      },
    );
  }
}

class MyCanvas extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var offset = Offset(size.width / 2, size.height / 2);

    print('width: ${size.width} , height: ${size.height}');
    print(
        'start $startDx (${(startDx / size.width) * 100}%), $startDy (${(startDy / size.height) * 100}%) end $endDx (${(endDx / size.width) * 100}%) , $endDy (${(endDy / size.height) * 100}%)');

    print(
        '[result] startX: ${600 * (startDx / size.width)}, startY: ${600 * (startDy / size.height)}, endX: ${600 * (endDx / size.width)}, endY: ${600 * (endDy / size.height)}');

    drawRectangle(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw true;
  }

  void drawRectangle(Canvas canvas, Offset offset) {
    // var rect = Rect.fromCenter(center: offset, width: W, height: W);
    var rect = Rect.fromPoints(Offset(startDx, startDy), Offset(endDx, endDy));

    var border = Paint()
      ..color = Colors.black
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    canvas.drawRect(rect, border);
  }
}
