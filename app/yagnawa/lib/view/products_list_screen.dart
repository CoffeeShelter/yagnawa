import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yagnawa/products.dart';
import 'package:yagnawa/view/product_info_screen.dart';
import '../constants.dart';
import '../products.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? productName = Get.parameters['productName'];

    productName ??= '';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
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
          }
        }

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
                Text(
                  '5분 이상 소요될 수 있습니다',
                  style: TextStyle(
                    fontSize: yDefaultFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          );
        }

        ProductList productList = snapshot.data as ProductList;

        if (productList.products.isEmpty) {
          return Column(
            children: <Widget>[
              TopArea(size: size),
              const Expanded(
                child: Center(
                  child: Text('검색 결과 없음'),
                ),
              ),
            ],
          );
        }

        return Column(
          children: <Widget>[
            TopArea(size: size),
            Expanded(
              child: Container(
                color: yDefaultGrey,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: productList.products.length,
                  itemBuilder: (BuildContext context, int index) {
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
      },
    );
  }
}

class ItemCard extends StatelessWidget {
  ItemCard({
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

  final Map<String, String> headers = {
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000",
  };

  @override
  Widget build(BuildContext context) {
    var noImage = Container(
      width: size.width * 0.2,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/No-Image-Found.png"),
        ),
      ),
    );

    var netImage = Container(
      width: size.width * 0.2,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            product.image,
            headers: headers,
          ),
        ),
      ),
    );

    // var image = product.image != ''
    //     ? NetworkImage(product.image)
    //     : const AssetImage("assets/images/No-Image-Found.png");

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
                  product.image == '' ? noImage : netImage,
                  SizedBox(
                    width: size.width * 0.65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          product.productName,
                          style: const TextStyle(
                            fontSize: yDefaultBigFontSize - 2,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
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
                                  fontSize: yDefaultBigFontSize - 4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                                overflow: TextOverflow.ellipsis,
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
          ],
        ),
      ),
      onTap: () {
        Get.to(
          ProductInfoPage(
            productCode: product.productCode,
            isdetected: false,
          ),
        );
        // Get.toNamed('/product?productCode=${product.productCode}');
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
          Container(
            alignment: Alignment.topLeft,
            width: size.width * 0.3,
            child: IconButton(
              visualDensity: VisualDensity.compact,
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
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: <Widget>[
            //     IconButton(icon: const Icon(Icons.camera), onPressed: () {}),
            //     IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            //   ],
            // ),
          )
        ],
      ),
    );
  }
}
