import 'package:flutter/widgets.dart';

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

  final markImagePathes = [
    'assets/images/kor_functional.png',
    'assets/images/gmp.png',
  ];

  @override
  Widget build(BuildContext context) {
    String markImagePath = marks[mark];

    return Container(
      width: 64,
      height: 64,
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(markImagePath),
        ),
      ),
    );
  }
}
