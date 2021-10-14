import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'components/body.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  var vid, auth;
  OtpScreen(this.vid, this.auth);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(vid, auth),
    );
  }
}
