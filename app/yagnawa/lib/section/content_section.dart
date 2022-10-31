import 'package:flutter/material.dart';
import '../constants.dart';
import '../products.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  List<Widget> getContents() {
    List<Widget> contentList = [];

    for (String content in product.contents) {
      var obj = Container(
        margin: const EdgeInsets.only(
          top: 10.0,
        ),
        padding: const EdgeInsets.only(
          bottom: 10.0,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: yDefaultDarkGreen, width: 2.0),
          ),
        ),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );

      contentList.add(obj);
    }

    return contentList;
  }

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(
              top: 3,
              bottom: 10,
            ),
            child: const Text(
              '함량 정보',
              style: TextStyle(
                fontSize: yDefaultBigFontSize,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: getContents(),
            ),
          ),
          TextButton(
            child: const Text('+ 더보기'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
