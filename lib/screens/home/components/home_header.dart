import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'drawerstatus.dart';
import 'icon_btn_with_counter.dart';
import 'location.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key key, this.status, this.drawerStatus}) : super(key: key);
  final statusCallback status;
  final drawerStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SearchField(),
          Location(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () {},
          ),
          GestureDetector(
            onTap: () {
              status(!drawerStatus);
            },
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(12)),
                height: getProportionateScreenWidth(46),
                width: getProportionateScreenWidth(46),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.black,
                        width: getProportionateScreenWidth(46),
                        height: 1.0,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        width: getProportionateScreenWidth(46) * .4,
                        color: Colors.black,
                        height: 1.0,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        width: getProportionateScreenWidth(46) * .3,
                        color: Colors.black,
                        height: 1.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
