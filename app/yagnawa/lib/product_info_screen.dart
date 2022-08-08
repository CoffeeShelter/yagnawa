import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'appbar.dart';

class ProductInfoPage extends StatelessWidget {
  const ProductInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YagNaWa',
      home: Scaffold(
        appBar: yacnawaAppBar(),
        body: const ProductInfoScreen(),
      ),
    );
  }
}

class ProductInfoScreen extends StatelessWidget {
  const ProductInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.green[900],
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            // 제품 이미지
            Container(
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/product04.jpg",
                  ),
                ),
              ),
            ),

            // 제품 명, 회사 명, 인증 현황
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(
                top: 3,
              ),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    '고려은단 비타민C 1000 + 비타민D',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    '고려은단 헬스케어(주)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1.5,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(Icons.check),
                      ),
                      const Text(
                        '인증 현황',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      CertifiedMark(
                        markImage: AssetImage("assets/images/gmp.png"),
                      ),
                      CertifiedMark(
                        markImage:
                            AssetImage("assets/images/kor_functional.png"),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // 기능성
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(
                top: 3,
              ),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    '기능성',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '1. 결합조직 형성과 기능유지에 필요\n2.철의 흡수에 필요\n3.유해산소로부터 세포를 보호하는데 필요',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // 함량 정보
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(
                top: 3,
              ),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(
                      top: 3,
                    ),
                    child: const Text(
                      '함량 정보',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(
                      top: 3,
                    ),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            '영양성분',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    margin: const EdgeInsets.only(right: 10.0),
                                    child: const Text('탄수화물')),
                                SizedBox(
                                  width: size.width * 0.5,
                                  height: 10.0,
                                  child: SfLinearGauge(
                                    showAxisTrack: false,
                                    showLabels: false,
                                    showTicks: false,
                                    ranges: const <LinearGaugeRange>[
                                      LinearGaugeRange(
                                        color: Colors.green,
                                        startValue: 0,
                                        endValue: 100,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    children: const <Widget>[
                                      Text('비타민'),
                                      Text('1,00000%'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 제품 추천
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                top: 3,
              ),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text('이런 제품은 어떤가요?'),
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
                            productImage:
                                AssetImage("assets/images/product01.jpg"),
                          ),
                          RecommendationProduct(
                            componyName: 'erom',
                            productName: '이롬 착한비타민C',
                            productImage:
                                AssetImage("assets/images/product02.jpg"),
                          ),
                          RecommendationProduct(
                            componyName: '대웅제약',
                            productName: '대웅 비타C',
                            productImage:
                                AssetImage("assets/images/product03.jpg"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 구매하러 가기 버튼
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                top: 3,
              ),
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Text(
                '구매하러 가기',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CertifiedMark extends StatelessWidget {
  const CertifiedMark({
    Key? key,
    required this.markImage,
  }) : super(key: key);

  final AssetImage markImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: markImage,
        ),
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
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          Text(
            componyName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
