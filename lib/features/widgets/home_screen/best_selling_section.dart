import 'package:flutter/material.dart';

import '../../../constant/constant.dart';
import '../../../views/screens/product_details_screen.dart';
import '../../components/card_body.dart';
import '../../components/product_card_button.dart';
import '../../components/size_config.dart';
import '../../models/product_model.dart';

class BestSellingSection extends StatelessWidget {
  const BestSellingSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.getScreenPropotionHeight(300),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CardBody(
            width: SizeConfig.getScreenPropotionWidth(298),
            height: SizeConfig.getScreenPropotionHeight(300),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    product: bestSelling[index],
                  ),
                ),
              );
            },
            index: index,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 19,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    bestSelling[index].name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    bestSelling[index].modelNo,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          bestSelling[index].description,
                          style: const TextStyle(
                            color: kTextLightColor,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Hero(
                            tag: bestSelling[index].id,
                            child: Image.asset(
                              bestSelling[index].images[0],
                              width: SizeConfig.getScreenPropotionWidth(100),
                              height: SizeConfig.getScreenPropotionHeight(170),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ProductCardBottom(
                    product: bestSelling[index],
                  ),
                )
              ],
            ),
          );
        },
        itemCount: bestSelling.length,
      ),
    );
  }
}
