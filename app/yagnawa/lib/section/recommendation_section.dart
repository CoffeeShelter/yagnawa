import 'package:flutter/material.dart';
import '../constants.dart';
import '../products.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  List<Widget> getRecoFrame(
      List<Product> recommendedProducts, String currentProductCode) {
    List<Widget> recoFrame = [];

    for (Product product in recommendedProducts) {
      if (product.productCode == currentProductCode) {
        continue;
      }

      var widget = RecommendationProduct(
        componyName: product.productName,
        productName: product.componyName,
        productImage: product.image != ''
            ? NetworkImage(product.image)
            : const AssetImage('assets/images/No-Image-Found.png'),
      );

      recoFrame.add(widget);
    }

    return recoFrame;
  }

  @override
  Widget build(BuildContext context) {
    List<Product> recommendedProducts = product.recommendedProducts.products;

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(
        top: 3,
      ),
      padding: const EdgeInsets.all(yDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              bottom: 10,
            ),
            alignment: Alignment.topLeft,
            child: const Text(
              '이런 제품은 어떤가요?',
              style: TextStyle(
                fontSize: yDefaultBigFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    getRecoFrame(recommendedProducts, product.productCode),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
const <Widget>[
  RecommendationProduct(
    componyName: '대웅제약',
    productName: '대웅 비타C',
    productImage: AssetImage("assets/images/product01.jpg"),
  ),
  RecommendationProduct(
    componyName: 'erom',
    productName: '이롬 착한비타민C',
    productImage: AssetImage("assets/images/product02.jpg"),
  ),
  RecommendationProduct(
    componyName: '대웅제약',
    productName: '대웅 비타C',
    productImage: AssetImage("assets/images/product03.jpg"),
  ),
],
*/

class RecommendationProduct extends StatelessWidget {
  const RecommendationProduct({
    Key? key,
    required this.productName,
    required this.componyName,
    required this.productImage,
  }) : super(key: key);

  final String productName;
  final String componyName;
  final dynamic productImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 2.0,
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(7.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: productImage,
                ),
              ),
            ),
          ),
          Text(
            productName,
            style: const TextStyle(
              fontSize: yDefaultFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          Text(
            componyName,
            style: const TextStyle(
              fontSize: yDefaultFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
