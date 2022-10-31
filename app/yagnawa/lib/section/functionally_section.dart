import 'package:flutter/material.dart';
import '../constants.dart';
import '../products.dart';

class FunctionallySection extends StatelessWidget {
  const FunctionallySection({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  List<Widget> getFunctionList() {
    List<Widget> functionList = [];

    for (String function in product.functionality) {
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
          function,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );

      functionList.add(obj);
    }

    return functionList;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '기능성',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getFunctionList(),
          ),
        ],
      ),
    );
  }
}
