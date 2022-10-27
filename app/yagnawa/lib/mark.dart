import 'package:flutter/widgets.dart';

class CertifiedMark extends StatelessWidget {
  CertifiedMark({
    Key? key,
    required this.mark,
  }) : super(key: key);

  final String mark;

  final markList = [
    'korCertifiMark (국내 건강기능식품)',
    'gmp (국내 GMP)',
    'usda (미국 유기농)',
    'usp (미국 USP)',
    'aco (호주 유기농)',
  ];

  final markImagePathes = [
    'assets/images/kor_functional.png',
    'assets/images/gmp.png',
  ];

  @override
  Widget build(BuildContext context) {
    int index = markList.indexOf(mark);
    String markImagePath = markImagePathes[index];

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
