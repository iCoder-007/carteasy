import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../constants.dart';

class DiscountBanner extends StatefulWidget {
  DiscountBanner({
    Key key,
  }) : super(key: key);

  @override
  _DiscountBannerState createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  var currentPage = 0;

  var items = [
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://source.unsplash.com/1600x900/?fastfood'))),
    ),
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              fit: BoxFit.fill,
              image:
                  NetworkImage('https://source.unsplash.com/1600x900/?art'))),
    ),
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              fit: BoxFit.fill,
              image:
                  NetworkImage('https://source.unsplash.com/1600x900/?food'))),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: CarouselSlider(
              items: items,
              options: CarouselOptions(
                aspectRatio: 16 / (9 * .85),
                viewportFraction: .85,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                pageSnapping: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, i) {
                  setState(() {
                    currentPage = index;
                  });
                },
                scrollDirection: Axis.horizontal,
              )),
        ),
        Container(
          height: MediaQuery.of(context).size.width * (9 / 16),
          padding: EdgeInsets.only(bottom: 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: (items.length * 6) + 40.0,
              height: 10,
              decoration: BoxDecoration(
                  color: Color(0xFFCFC8C8),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    items.length,
                    (index) => buildDot(index: index),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Color(0xFFFFFFFF) : Color(0xFFF7EFEF),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
