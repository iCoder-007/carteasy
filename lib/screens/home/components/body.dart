import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'drawerstatus.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatefulWidget {
  const Body({this.status, this.drawerStatus});
  final statusCallback status;
  final drawerStatus;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(35)),
          HomeHeader(
            status: widget.status,
            drawerStatus: widget.drawerStatus,
          ),
          SizedBox(height: getProportionateScreenWidth(20)),
          DiscountBanner(),
          Categories(),
          SpecialOffers(),
          SizedBox(height: getProportionateScreenWidth(30)),
          PopularProducts(),
          SizedBox(height: getProportionateScreenWidth(30)),
        ],
      ),
    );
  }
}
