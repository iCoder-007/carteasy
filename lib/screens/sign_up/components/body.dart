import 'dart:async';
import 'dart:math';
import 'package:carteasy/components/default_button.dart';
import 'package:carteasy/screens/API/signin.dart';
import 'package:carteasy/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'FormCard.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;

  var r = new Random();

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );
  var mobileNo;
  void setmn(mn) {
    print(mn);
    setState(() {
      mobileNo = mn.toString().trim();
    });
  }

  String phoneNo, smssent, verificationId;

  get verifiedSuccess => null;

  Future<void> verfiyPhone() async {
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
      this.verificationId = verId;
      smsCodeDialoge(context).then((value) {
        print("Code Sent");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential credential) async {
      AuthResult result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      FirebaseUser user = result.user;
      if (user != null) {
        // SignIn.signIn(mobileNo.toString()).then((value) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        // });
      } else {
        print('failed');
      }
      Navigator.pop(context);
    };
    final PhoneVerificationFailed verifyFailed = (AuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + mobileNo,
      timeout: const Duration(seconds: 60),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: null,
    );
  }

  Future<bool> smsCodeDialoge(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new Dialog(
              child: Container(
            height: 420,
            padding: EdgeInsets.all(10),
            child: Form(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  Text(
                    "OTP Verification",
                    style: headingStyle,
                  ),
                  Text(
                    "We sent your code to +91 ${mobileNo.toString().substring(0, 6)} ****",
                    style: TextStyle(fontSize: 12),
                  ),
                  buildTimer(),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 0),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: true,
                        obscuringCharacter: '*',
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v.length < 3) {
                            return null;
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor:
                              hasError ? Colors.orange : Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),

                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        boxShadows: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          print("Completed");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                      )),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  DefaultButton(
                    text: "Continue",
                    press: () async {
                      var code = textEditingController.text;
                      FirebaseAuth.instance.currentUser().then((user) {
                        if (user != null) {
                          Navigator.of(context).pop();
                          print('not sign');
                          print(user);
                        } else {
                          signIn(code);

                          Navigator.of(context).pop();
                        }
                      });
                    },
                  ),
                  SizedBox(height: 35),
                  GestureDetector(
                    onTap: () {
                      // OTP code resend
                    },
                    child: Text(
                      "Resend OTP Code",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
          ));
        });
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      SignIn.signIn(mobileNo.toString()).then((value) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/images/image_01.png"),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(child: Image.asset("assets/images/image_02.png"))
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("LOGO",
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(46),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(280),
                  ),
                  FormCard(
                    mobileNumber: setmn,
                  ),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(),
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (FirebaseAuth.instance.currentUser() !=
                                    null) {
                                  FirebaseAuth.instance.signOut();
                                }
                                verfiyPhone();
                              },
                              child: Center(
                                child: Text("SIGNIN",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: Duration(seconds: 60),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
