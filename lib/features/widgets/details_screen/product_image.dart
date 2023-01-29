import 'package:flutter/material.dart';

import '../../components/size_config.dart';
import '../../models/product_model.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.getScreenPropotionHeight(80.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Image.asset(
              product.images[index],
            ),
          );
        },
        itemCount: product.images.length,
      ),
    );
  }
}
