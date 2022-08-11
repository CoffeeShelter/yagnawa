import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final myController = TextEditingController();

  MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Get.toNamed('/product?productName=${myController.text}');
                    myController.clear();
                  },
                ),
              ),
              onSubmitted: (value) {
                Get.toNamed('/product?productName=$value');
                myController.clear();
              },
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
        Get.toNamed('/product?productName=$title');
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

/*
child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.green;
              } else {
                return yDefaultDarkGreen;
              }
            },
          ),
        ),
        child: const Text('Go'),
        onPressed: () {
          Get.toNamed('/product?productName=비타민');
        },
      ),
    );

 */
