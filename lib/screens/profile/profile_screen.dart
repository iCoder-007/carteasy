import 'package:carteasy/screens/home/components/drawerstatus.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  const ProfileScreen({this.status});
  final statusCallback status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        status: status,
      ),
    );
  }
}
