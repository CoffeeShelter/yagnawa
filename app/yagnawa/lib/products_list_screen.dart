import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yagnawa/products.dart';
import 'constants.dart';
import 'products.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? productName = Get.parameters['productName'];

    productName ??= '';

    return MaterialApp(
      title: 'YagNaWa',
      home: Scaffold(
        body: ProductListScreen(
          productName: productName,
        ),
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  ProductListScreen({Key? key, required this.productName}) : super(key: key);

  final List<Color> colors = [yDefaultDarkGreen, yDefaultGreen];
  final String productName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: getProducts(
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
          return Column(
            children: <Widget>[
              TopArea(size: size),
              Expanded(
                child: Container(
                  color: yDefaultGrey,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      ProductList productList = snapshot.data as ProductList;

                      return ItemCard(
                        size: size,
                        colors: colors,
                        index: index,
                        product: productList.products[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.size,
    required this.colors,
    required this.index,
    required this.product,
  }) : super(key: key);

  final Size size;
  final List<Color> colors;
  final int index;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 6.0,
          bottom: 6.0,
        ),
        color: Colors.white,
        height: size.height * 0.17,
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
                  SizedBox(
                    width: 330,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          product.productName,
                          style: const TextStyle(
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
                            Text(
                              product.componyName,
                              style: const TextStyle(
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
        ),
      ),
      onTap: () {
        Get.toNamed('/product?productCode=${product.productCode}');
      },
    );
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
