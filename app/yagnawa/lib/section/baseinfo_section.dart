import 'package:flutter/material.dart';
import '../constants.dart';
import '../mark.dart';
import '../products.dart';

class BaseInfoSection extends StatelessWidget {
  const BaseInfoSection({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

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
            product.productName,
            style: const TextStyle(
              fontSize: yDefaultBigFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            product.componyName,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CertifiedMark(
                mark: 'korCertifiMark (국내 건강기능식품)',
              ),
              CertifiedMark(
                mark: 'gmp (국내 GMP)',
              ),
            ],
          )
        ],
      ),
    );
  }
}
