import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'view/image_editor.dart';
import 'constants.dart';
import 'package:get/get.dart';
import 'camera.dart';
import 'image_edit_test.dart';

enum Menu { gallery, camera }

class MainScreen extends StatelessWidget {
  final myController = TextEditingController();

  MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: yDefaultGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // 앱 타이틀 프레임
            Container(
              margin: const EdgeInsets.only(
                top: 100.0,
                bottom: 30.0,
              ),
              child: const Text(
                '약나와',
                style: TextStyle(
                  color: yDefaultDarkGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontFamily: 'Jua',
                ),
              ),
            ),
            // 검색 프레임
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(
                horizontal: yDefaultPadding,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: yDefaultPadding,
              ),
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  PopupMenuButton<Menu>(
                    icon: const Icon(
                      Icons.camera,
                      color: yDefaultGreen,
                      size: 22.0,
                    ),
                    onSelected: (Menu item) async {
                      switch (item) {
                        case Menu.gallery:
                          PickedFile? pickedFile = await chooseImage();
                          if (pickedFile != null) {
                            File image = File(pickedFile.path);
                            // Get.to(() => ImageEditor(image: image));
                            // Get.to(() => const ImageEditorCanvas());
                            Get.to(() => ImageEditor(image: image));
                          }
                          break;
                        case Menu.camera:
                          PickedFile? pickedFile = await getImage();
                          if (pickedFile != null) {
                            File image = File(pickedFile.path);
                            // Get.to(() => ImageEditor(image: image));
                          }
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<Menu>>[
                      const PopupMenuItem<Menu>(
                        value: Menu.gallery,
                        child: Text('이미지 가져오기'),
                      ),
                      const PopupMenuItem<Menu>(
                        value: Menu.camera,
                        child: Text('직접 촬영'),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width * 0.67,
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: yDefaultGreen.withOpacity(0.5),
                          fontSize: 18.0,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search_rounded),
                          color: yDefaultGreen,
                          iconSize: 22.0,
                          onPressed: () {
                            Get.toNamed(
                                '/products?productName=${myController.text}');
                            myController.clear();
                          },
                        ),
                      ),
                      onSubmitted: (value) {
                        Get.toNamed('/products?productName=$value');
                        myController.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
            // 바로가기 버튼 프레임
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(yDefaultPadding),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    QuickButton(
                      title: '홍삼',
                      imagePath: 'assets/images/red-ginseng.png',
                    ),
                    QuickButton(
                      title: '루테인',
                      imagePath: 'assets/images/eye.png',
                    ),
                    QuickButton(
                      title: '비타민C',
                      imagePath: 'assets/images/vitamin-c.png',
                    ),
                    QuickButton(
                      title: '오메가3',
                      imagePath: 'assets/images/omega3.png',
                    ),
                    QuickButton(
                      title: '유산균',
                      imagePath: 'assets/images/lactobacillus.png',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuickButton extends StatelessWidget {
  final String title;
  final String imagePath;

  const QuickButton({
    Key? key,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/products?productName=$title');
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: yDefaultPadding,
          right: yDefaultPadding,
        ),
        child: Column(
          children: [
            Container(
              width: 64.0,
              height: 64.0,
              margin: const EdgeInsets.only(
                bottom: 7.0,
              ),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: yDefaultFontSize,
                fontFamily: 'Jua',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
