import 'package:carteasy/screens/home/components/drawerstatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormCard extends StatelessWidget {
  const FormCard({this.mobileNumber});
  final mobileCallback mobileNumber;
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding:
            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Login",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(45),
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            TextField(
              onChanged: (value) {
                // print(value);
                mobileNumber(value);
              },
              decoration: InputDecoration(
                labelText: 'Phone',
                prefixText: '+91',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
