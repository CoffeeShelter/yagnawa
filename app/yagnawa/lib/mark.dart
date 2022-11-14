import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'constants.dart';

class CertifiedMark extends StatelessWidget {
  CertifiedMark({
    Key? key,
    required this.mark,
  }) : super(key: key);

  final String mark;

  final Map marks = {
    'korCertifiMark (국내 건강기능식품)': 'assets/images/kor_functional.png',
    'gmp (국내 GMP)': 'assets/images/gmp.png',
    'usda (미국 유기농)': 'assets/images/usda.png',
    'usp (미국 USP)': 'assets/images/usp.jpg',
    'aco (호주 유기농)': 'assets/images/aco.png',
  };

  final Map details = {
    'korCertifiMark (국내 건강기능식품)': '식약처에서 인정한 기능성 원료를 사용하여 제조·가공한 식품에 표시',
    'gmp (국내 GMP)': '원료의 구입부터 완제품 출하까지 모든 공정관리를 표준화한 작업장에서 제조한 제품에 표시',
    'usda (미국 유기농)':
        '최소 3년 이상 힙성비료, 방사선처리, 합성농약을 일체 사용하지 않고 농산물의 농사방법과 가공방법 등을 규정 - 물과 소금을 제외하고 전체 성분의 95% 이상 유기농 성분이어야함',
    'usp (미국 USP)':
        '식이 보충제 완제품, 식이보충제 원료, 의약품원료, 그리고 약학 첨가물에 관한 검증 서비스를 제공하고 있으며 USP 검증 조건을 충족하는 제품 및 원재료는 USP 검증마크 표시',
    'aco (호주 유기농)': '유기농 원료 비중이 95% 이상인 제품에 표시',
  };

  final Map markNames = {
    'korCertifiMark (국내 건강기능식품)': '건강기능식품 (한국)',
    'gmp (국내 GMP)': 'GMP (한국)',
    'usda (미국 유기농)': 'USDA (미국)',
    'usp (미국 USP)': 'USP (미국)',
    'aco (호주 유기농)': 'ACO (호주)',
  };

  final markImagePathes = [
    'assets/images/kor_functional.png',
    'assets/images/gmp.png',
  ];

  @override
  Widget build(BuildContext context) {
    String markImagePath = marks[mark];

    return GestureDetector(
      child: Container(
        width: 64,
        height: 64,
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(markImagePath),
          ),
        ),
      ),
      onTap: () {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                markNames[mark],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: yDefaultBigFontSize,
                  fontWeight: FontWeight.bold,
                  color: yDefaultDarkGreen,
                ),
              ),
              content: Text(
                details[mark],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: yDefaultFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
