import 'package:flutter/material.dart';
import '../constants.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                children: const <Widget>[
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendationProduct extends StatelessWidget {
  const RecommendationProduct({
    Key? key,
    required this.productName,
    required this.componyName,
    required this.productImage,
  }) : super(key: key);

  final String productName;
  final String componyName;
  final AssetImage productImage;

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
