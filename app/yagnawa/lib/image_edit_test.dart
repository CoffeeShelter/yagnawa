import 'package:flutter/material.dart';

var W = 100.0;
var startDx = 0.0;
var startDy = 0.0;
var endDx = 0.0;
var endDy = 0.0;
bool isClick = false;

var image = const AssetImage('assets/images/product01.jpg');

void main() {
  runApp(const ImageEditor());
}

class ImageEditor extends StatelessWidget {
  const ImageEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Image Edit Test',
      home: ImageCanvas(),
    );
  }
}

class ImageCanvas extends StatefulWidget {
  const ImageCanvas({Key? key}) : super(key: key);

  @override
  State<ImageCanvas> createState() => _ImageCanvasState();
}

class _ImageCanvasState extends State<ImageCanvas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 에디터 테스트'),
      ),
      body: GestureDetector(
        child: CustomPaint(
          // painter: MyCanvas(),
          foregroundPainter: MyCanvas(),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: image,
              ),
            ),
          ),
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
      ),
    );
  }
}

class MyCanvas extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var offset = Offset(size.width / 2, size.height / 2);

    print('start $startDx , $startDy end $endDx , $endDy');

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
