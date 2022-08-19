import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yagnawa/products.dart';
import 'constants.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({Key? key}) : super(key: key);

  List<Color> colors = [yDefaultDarkGreen, yDefaultGreen];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String? productName = Get.parameters['productName'];

    productName ??= '';

    return Scaffold(
      body: Column(
        children: <Widget>[
          TopArea(size: size),
          FutureBuilder(
            future: getProduct(
              productName: productName,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                print('기다리는중');
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        '제품 정보를 가져오는 중 입니다',
                        style: TextStyle(
                          fontSize: yDefaultFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                print("에러");
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        '제품 정보를 가져오지 못했습니다',
                        style: TextStyle(
                          fontSize: yDefaultFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        '${snapshot.error}',
                        style: const TextStyle(
                          fontSize: yDefaultFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Expanded(
                  child: Container(
                    color: yDefaultGrey,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 100,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemCard(
                          size: size,
                          colors: colors,
                          index: index,
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.size,
    required this.colors,
    required this.index,
  }) : super(key: key);

  final Size size;
  final List<Color> colors;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 6.0,
          bottom: 6.0,
        ),
        color: Colors.white,
        height: size.height * 0.15,
        child: Stack(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              color: colors[index % 2],
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(5.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: size.width * 0.2,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/No-Image-Found.png",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 5.0,
                    ),
                    width: 330,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          '건강기능식품 상품 명 어쩌구 저쩌궁',
                          style: TextStyle(
                            fontSize: yDefaultBigFontSize + 2,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                right: 5.0,
                              ),
                              child: const Icon(Icons.business),
                            ),
                            const Text(
                              '건강기능식품 회사 어쩌구 저쩌궁',
                              style: TextStyle(
                                fontSize: yDefaultBigFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class TopArea extends StatelessWidget {
  const TopArea({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 50.0,
        bottom: 30.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.3,
            child: IconButton(
              alignment: Alignment.centerLeft,
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          const Text(
            '약나와',
            style: TextStyle(
              color: yDefaultDarkGreen,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              fontFamily: 'Jua',
            ),
          ),
          SizedBox(
            width: size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                IconButton(icon: Icon(Icons.camera), onPressed: null),
                IconButton(icon: Icon(Icons.search), onPressed: null),
              ],
            ),
          )
        ],
      ),
    );
  }
}
