import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yagnawa/appbar.dart';
import 'package:yagnawa/constants.dart';
import 'package:yagnawa/main_screen.dart';
import 'package:yagnawa/products.dart';
import 'package:yagnawa/view/product_select_screen.dart';
import 'package:yagnawa/widgets/Loading.dart';

bool isClick = false;

class ImageEditor extends StatelessWidget {
  final String imageFilePath;

  const ImageEditor({
    required this.imageFilePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: yacnawaAppBar(),
      body: ImagePaintPage(
        imageFilePath: imageFilePath,
      ),
    );
  }
}

class ImagePaintPage extends StatefulWidget {
  final String imageFilePath;

  const ImagePaintPage({
    required this.imageFilePath,
    Key? key,
  }) : super(key: key);

  @override
  State<ImagePaintPage> createState() => _ImagePaintPageState();
}

class _ImagePaintPageState extends State<ImagePaintPage> {
  ui.Image? image;
  bool isLoad = false;
  dynamic uintImage;
  bool isScale = false;
  final double minScale = 1.0;
  final double maxScale = 5.0;

  var startDx = 0.0;
  var startDy = 0.0;
  var endDx = 0.0;
  var endDy = 0.0;

  bool isDrawing = false;
  bool imageLoading = true;

  @override
  void initState() {
    super.initState();
    loadImage(widget.imageFilePath);
  }

  // Future loading() async {
  //   var data = (await rootBundle.load('assets/images/product03.jpg'))
  //       .buffer
  //       .asUint8List();

  //   var image = await decodeImageFromList(data);
  //   uintImage = data;

  //   return image;
  // }

  Future loadImage(String path) async {
    setState(() {
      imageLoading = true;
    });

    File data = File(path);

    final bytes = await data.readAsBytes();
    final image = await decodeImageFromList(bytes);

    // final tempImage = await loading();
    // setState(() => this.image = tempImage);
    setState(() {
      this.image = image;
      uintImage = bytes;
      imageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoad) {
      return const LoadingWidget(
        text: '인증마크를 탐지하고 있습니다',
      );
    }

    if (imageLoading) {
      return const LoadingWidget(
        text: '이미지를 불러오고 있습니다',
      );
    }

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: InteractiveViewer(
            clipBehavior: Clip.none,
            minScale: minScale,
            maxScale: maxScale,
            scaleEnabled: !isDrawing,
            child: FittedBox(
              child: GestureDetector(
                child: SizedBox(
                  width: image!.width.toDouble(),
                  height: image!.height.toDouble(),
                  child: CustomPaint(
                    painter: ImagePainter(image!),
                    foregroundPainter: RectPainter(
                      startDx: startDx,
                      startDy: startDy,
                      endDx: endDx,
                      endDy: endDy,
                    ),
                  ),
                ),

                onHorizontalDragDown: (details) {
                  if (isDrawing) {
                    print('드레그 시작!');
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
                  }
                },
                //
                onHorizontalDragEnd: (details) {
                  if (isDrawing) {
                    print('드레그 끝!');
                    setState(
                      () {
                        isClick = false;
                      },
                    );
                  }
                },
                //
                onHorizontalDragUpdate: (details) {
                  if (isDrawing) {
                    print('드레그 중. . .');
                    setState(() {
                      endDx = details.localPosition.dx;
                      endDy = details.localPosition.dy;
                    });
                    print(endDx);
                  }
                },
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: 64,
            width: 64,
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(90),
            ),
            child: IconButton(
              iconSize: 32.0,
              color: yDefaultDarkGreen,
              icon: const Icon(Icons.double_arrow_sharp),
              onPressed: () {
                setState(() {
                  isLoad = true;
                });
                //Get.toNamed('/products?productName=$value');
                // [startDx, startDy, endDx, endDy]
                var boundingBoxVertex = [startDx, startDy, endDx, endDy];
                print(boundingBoxVertex);
                uploadImage('비타민', uintImage, boundingBoxVertex).then(
                  (value) {
                    setState(() {
                      isLoad = false;
                    });
                    Get.off(
                      () => ProductSelectPage(
                        data: value,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 64,
            width: 64,
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(90),
            ),
            child: IconButton(
              iconSize: 32.0,
              color: yDefaultDarkGreen,
              icon: isDrawing
                  ? const Icon(Icons.edit)
                  : const Icon(Icons.pan_tool_alt_rounded),
              onPressed: () {
                setState(() {
                  isDrawing = !isDrawing;
                });
              },
            ),
          ),
        ),
      ],
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
          setState(() {
            isLoad = true;
          });
          //Get.toNamed('/products?productName=$value');
          // [startDx, startDy, endDx, endDy]
          var boundingBoxVertex = [startDx, startDy, endDx, endDy];
          print(boundingBoxVertex);
          uploadImage('비타민', uintImage, boundingBoxVertex).then(
            (value) {
              setState(() {
                isLoad = false;
              });
              Get.off(
                () => ProductSelectPage(
                  data: value,
                ),
              );
            },
          );
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
          Get.to(MainScreen());
        },
      ),
    );
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image image;

  const ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    canvas.drawImage(image, Offset.zero, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RectPainter extends CustomPainter {
  RectPainter({
    required this.startDx,
    required this.startDy,
    required this.endDx,
    required this.endDy,
  });

  double startDx;
  double startDy;
  double endDx;
  double endDy;

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Rect.fromPoints(Offset(startDx, startDy), Offset(endDx, endDy));

    var border = Paint()
      ..color = Colors.red
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke;

    // print('width: ${size.width} , height: ${size.height}');

    // print('''
    //   startDx $startDx , startDy $startDy
    //   endDx $endDx , endDy $endDy
    //   ''');
    // print('''
    //   start $startDx (${(startDx / size.width) * 100}%) , $startDy (${(startDy / size.height) * 100}%)
    //   end $endDx (${(endDx / size.width) * 100}%) , $endDy (${(endDy / size.height) * 100}%)
    //   ''');

    // print(
    //     '[result] startX: ${600 * (startDx / size.width)}, startY: ${600 * (startDy / size.height)}, endX: ${600 * (endDx / size.width)}, endY: ${600 * (endDy / size.height)}');

    // print('=================================');

    canvas.drawRect(rect, border);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

/*

Container(
        color: yDefaultGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '제품명을 드레그하세요',
              style: TextStyle(
                color: yDefaultDarkGreen,
                fontSize: 20,
                fontFamily: 'Jua',
              ),
            ),
            image == null
                ? const CircularProgressIndicator()
                : InteractiveViewer(
                    minScale: minScale,
                    maxScale: maxScale,
                    onInteractionStart: (details) {
                      print('sacle...');
                      setState(() {
                        isScale = true;
                      });
                    },
                    onInteractionEnd: (details) {
                      print('end sacle');
                      setState(() {
                        isScale = false;
                      });
                    },
                    panEnabled: false,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.5,
                      margin: const EdgeInsets.only(bottom: 30),
                      child: FittedBox(
                        child: GestureDetector(
                          child: SizedBox(
                            width: image!.width.toDouble(),
                            height: image!.height.toDouble(),
                            child: CustomPaint(
                              painter: ImagePainter(image!),
                              foregroundPainter: RectPainter(),
                            ),
                          ),

                          onHorizontalDragDown: (details) {
                            if (isScale == false) {
                              print('드레그 시작!');
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
                            }
                          },
                          //
                          onHorizontalDragEnd: (details) {
                            if (isScale == false) {
                              print('드레그 끝!');
                              setState(
                                () {
                                  isClick = false;
                                },
                              );
                            }
                          },
                          //
                          onHorizontalDragUpdate: (details) {
                            if (isClick && isScale == false) {
                              print('드레그 중. . .');
                              setState(() {
                                endDx = details.localPosition.dx;
                                endDy = details.localPosition.dy;
                              });
                              print(endDx);
                            }
                          },
                        ),
                      ),
                    ),
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

 */
