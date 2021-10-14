import 'package:carteasy/components/gradient_raised_button.dart';
import 'package:carteasy/models/Product.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              ProductImages(product: product),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    ProductDescription(
                      product: product,
                      pressOnSeeMore: () {},
                    ),
                    TopRoundedContainer(
                      color: Color(0xFFF6F7F9),
                      child: ColorDots(product: product),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: TopRoundedContainer(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
                bottom: getProportionateScreenWidth(15),
                top: getProportionateScreenWidth(0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.price}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  Spacer(),
                  RaisedGradientButton(
                      child: Text(
                        'Add To Cart',
                        style: TextStyle(color: Colors.white),
                      ),
                      gradient: primaryGradient,
                      radius: 30,
                      width: 150,
                      onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
