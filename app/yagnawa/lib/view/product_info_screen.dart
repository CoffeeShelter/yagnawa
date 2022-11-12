import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yagnawa/constants.dart';
import 'package:yagnawa/products.dart';
import 'package:yagnawa/view/comparison_site.dart';
import '../appbar.dart';
import '../section/baseinfo_section.dart';
import '../section/content_section.dart';
import '../section/functionally_section.dart';
import '../section/image_section.dart';
import '../section/recommendation_section.dart';

class ProductInfoPage extends StatelessWidget {
  const ProductInfoPage({
    Key? key,
    required this.productCode,
    required this.isdetected,
    this.marks,
  }) : super(key: key);

  final List<dynamic>? marks;
  final String productCode;
  final bool isdetected;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YagNaWa',
      home: Scaffold(
        appBar: yacnawaAppBar(),
        body: ProductInfoScreen(
          productCode: productCode,
          isdetected: isdetected,
          marks: marks,
        ),
      ),
    );
  }
}

class ProductInfoScreen extends StatelessWidget {
  final String productCode;
  final bool isdetected;
  final List<dynamic>? marks;

  const ProductInfoScreen({
    Key? key,
    required this.productCode,
    required this.isdetected,
    required this.marks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: getProduct(
        productCode: productCode,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // error
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

        // API 응답 기다리는 중
        if (snapshot.hasData == false) {
          print('기다리는중');
          return const LoadingScreen();
        }

        // API 응답 완료
        else {
          print("success");
          return InfoScreen(
            size: size,
            product: snapshot.data,
            isdetected: isdetected,
            marks: marks,
          );
        }
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}

class InfoScreen extends StatelessWidget {
  const InfoScreen({
    Key? key,
    required this.size,
    required this.product,
    required this.isdetected,
    required this.marks,
  }) : super(key: key);

  final Size size;
  final Product product;
  final bool isdetected;
  final List<dynamic>? marks;

  @override
  Widget build(BuildContext context) {
    bool isDetected = false;
    if (isdetected == true) {
      isDetected = isdetected;
    }

    if (product.marks.isNotEmpty) {
      isDetected = true;
    }

    return Container(
      color: Colors.green[900],
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            // 제품 이미지
            ImageSection(
              product: product,
              size: size,
            ),
            // 제품 명, 회사 명, 인증 현황
            BaseInfoSection(
              product: product,
              isDetected: isDetected,
              marks: marks,
            ),
            // 기능성
            FunctionallySection(product: product),
            // 함량 정보
            ContentSection(product: product),
            // 제품 추천
            RecommendationSection(product: product),
            // 구매하러 가기 버튼
            GoShopButton(product: product)
          ],
        ),
      ),
    );
  }
}

class GoShopButton extends StatelessWidget {
  const GoShopButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(
        top: 3,
      ),
      padding: const EdgeInsets.all(yDefaultPadding),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: TextButton(
        child: const Text(
          '구매하러 가기',
          style: TextStyle(
            fontSize: yDefaultBigFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onPressed: () {
          Get.to(ComparisonSite(productName: product.productName));
        },
      ),
    );
  }
}
