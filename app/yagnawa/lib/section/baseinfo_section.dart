import 'package:flutter/material.dart';
import '../constants.dart';
import '../mark.dart';
import '../products.dart';

class BaseInfoSection extends StatefulWidget {
  BaseInfoSection({
    Key? key,
    required this.product,
    required this.isDetected,
    required this.marks,
  }) : super(key: key);

  final Product product;
  bool isDetected;
  final List<dynamic>? marks;

  @override
  State<BaseInfoSection> createState() => _BaseInfoSectionState();
}

class _BaseInfoSectionState extends State<BaseInfoSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(
        top: 3,
      ),
      padding: const EdgeInsets.all(yDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.product.productName,
            style: const TextStyle(
              fontSize: yDefaultBigFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            widget.product.componyName,
            style: const TextStyle(
              fontSize: yDefaultBigFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const Divider(
            color: yDefaultDarkGreen,
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
                  fontSize: yDefaultFontSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          widget.isDetected
              ? MarkFrame(marks: widget.marks ?? [])
              : const Text('탐지된 인증마크가 없습니다.'),
          /*
              TextButton(
                  child: const Text("인증마크 탐지"),
                  onPressed: () {},
              ),
              */
        ],
      ),
    );
  }
}

class MarkFrame extends StatelessWidget {
  const MarkFrame({
    Key? key,
    required this.marks,
  }) : super(key: key);

  final List<dynamic> marks;

  List<Widget> getMarkList() {
    List<Widget> markList = [];

    for (String markName in marks) {
      var mark = CertifiedMark(
        mark: markName,
      );

      markList.add(mark);
    }

    return markList;
  }

  @override
  Widget build(BuildContext context) {
    return marks.isEmpty
        ? const Text('탐지된 인증마크가 없습니다.')
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getMarkList(),
          );
  }
}
