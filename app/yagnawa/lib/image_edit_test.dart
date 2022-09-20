import 'package:flutter/material.dart';

void main() {
  runApp(const ImageEditor());
}

class ImageEditor extends StatelessWidget {
  const ImageEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
      body: Container(
        child: CustomPaint(
          painter: MyCanvas(),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.black,
          ),
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
