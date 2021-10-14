import 'package:carteasy/screens/home/components/drawerstatus.dart';
import 'package:flutter/material.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  const Body({this.status});
  final statusCallback status;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '',
                  style: TextStyle(fontSize: 18),
                ),
                GestureDetector(
                    onTap: () {
                      status(false);
                    },
                    child: Icon(Icons.close))
              ],
            ),
          ),
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
