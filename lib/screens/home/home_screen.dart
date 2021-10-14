import 'package:carteasy/components/coustom_bottom_nav_bar.dart';
import 'package:carteasy/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../enums.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDrawerOpen = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  void onclick(status) {
    setState(() {
      if (status == true) {
        xOffset = MediaQuery.of(context).size.width * .1;
        yOffset = MediaQuery.of(context).size.height * .9;
        scaleFactor = 0.93;
        isDrawerOpen = true;
      } else {
        setState(() {
          xOffset = 0;
          yOffset = 0;
          scaleFactor = 1;
          isDrawerOpen = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProfileScreen(status: onclick),
          AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor)
              ..rotateY(isDrawerOpen ? -0.5 : 0),
            duration: Duration(milliseconds: 250),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color(0xF1DDDDDD),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(0, 4)),
            ]),
            child: Scaffold(
              body: Body(status: onclick, drawerStatus: isDrawerOpen),
              bottomNavigationBar:
                  CustomBottomNavBar(selectedMenu: MenuState.home),
            ),
          ),
        ],
      ),
    );
  }
}
