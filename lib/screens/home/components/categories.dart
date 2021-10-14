import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "Flash Deal",
      },
      {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
      {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},
    ];
    var colors = [
      [
        Color(0xFFFDE9DC),
        Color(0xFFFDDDC8),
      ],
      [Color(0xFFFCD0F4), Color(0xFFD9A0FF)],
      [Color(0xFFDAFFD9), Color(0xFFC3FFC3)],
      [Color(0xFFC4D9F8), Color(0xFF9BBBFF)],
      [Color(0xFFCCFFFF), Color(0xFF97FFF1)]
    ];
    var iconColor = [
      Color(0xFFFF6600),
      Color(0xFF9900FF),
      Color(0xFF1BA500),
      Color(0xFF0041CE),
      Color(0xFF02A1A7)
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {},
            color: colors[index],
            iconColor: iconColor[index],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
    @required this.color,
    @required this.iconColor,
  }) : super(key: key);

  final String icon, text;
  final List<Color> color;
  final Color iconColor;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(60),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                // color: Color(0xFFFFECDF),
                gradient: LinearGradient(colors: color),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                icon,
                color: iconColor,
              ),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
