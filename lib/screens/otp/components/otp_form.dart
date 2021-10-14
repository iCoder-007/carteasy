import 'dart:async';

import 'package:carteasy/components/default_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../size_config.dart';

// ignore: must_be_immutable
class OtpForm extends StatefulWidget {
  var vid, auth;

  OtpForm({
    this.vid,
    this.auth,
    Key key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType> errorController;

  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    super.dispose();
    errorController.close();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Form(
            key: formKey,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v.length < 3) {
                      return "I'm from validator";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: hasError ? Colors.orange : Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.blue.shade50,
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
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                )),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue",
            press: () async {
              var code = textEditingController.text;
              AuthCredential credential = PhoneAuthProvider.getCredential(
                  verificationId: widget.vid, smsCode: code);
              AuthResult result =
                  await widget.auth.signInWithCradential(credential);
              FirebaseUser user = result.user;
              if (user != null) {
                print(user);
              }
            },
          )
        ],
      ),
    );
  }
}
