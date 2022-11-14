import 'package:flutter/material.dart';
import '../constants.dart';
import '../products.dart';

class ContentSection extends StatefulWidget {
  const ContentSection({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ContentSection> createState() => _ContentSectionState();
}

class _ContentSectionState extends State<ContentSection> {
  bool isShow = false;

  List<Widget> getContents() {
    List<Widget> contentList = [];
    int index = 0;

    for (String content in widget.product.containContents) {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              content,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              widget.product.values[index],
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // child: Text(
        //   '$content : ${widget.product.values[index]}',
        //   style: const TextStyle(
        //     fontSize: 15.0,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.black,
        //   ),
        // ),
      );

      contentList.add(obj);
      index += 1;
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
          isShow
              ? ExtraField(
                  product: widget.product,
                )
              : Container(),
          TextButton(
            child: isShow ? const Text('- 최소화') : const Text('+ 더보기'),
            onPressed: () {
              setState(() {
                isShow = !isShow;
              });
            },
          )
        ],
      ),
    );
  }
}

class ExtraField extends StatelessWidget {
  const ExtraField({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  List<Widget> getExtra() {
    List<Widget> extraList = [];

    for (String extra in product.extra) {
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
          extra,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );

      extraList.add(obj);
    }

    return extraList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: getExtra(),
    );
  }
}
