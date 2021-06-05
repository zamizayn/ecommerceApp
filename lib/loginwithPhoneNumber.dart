import 'dart:io';

import 'package:ecommerce/helper/Colors.dart';
import 'package:ecommerce/helper/utils.dart';
import 'package:ecommerce/homepage.dart';
import 'package:ecommerce/widgets/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginWithNumber extends StatefulWidget {
  @override
  _LoginWithNumberState createState() => _LoginWithNumberState();
}

class _LoginWithNumberState extends State<LoginWithNumber> {
  TextEditingController controller = TextEditingController();
  final otpcontroller = TextEditingController();
  String verificationId = "";
  String currentCode = "";

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/firebase.png',
                    height: 250,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Login With Phone Number',
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: blackColor),
                        decoration: InputDecoration(
                            hintText: "Enter Your Mobile Number",
                            hintStyle: TextStyle(color: Colors.grey)),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: PinFieldAutoFill(
                          controller: otpcontroller,
                          keyboardType: kIsWeb
                              ? TextInputType.number
                              : Platform.isAndroid
                                  ? TextInputType.number
                                  : TextInputType.numberWithOptions(
                                      signed: true),
                          decoration: BoxLooseDecoration(
                            radius: Radius.circular(5),
                            strokeWidth: 2,
                            textStyle: TextStyle(
                                color: blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            strokeColorBuilder:
                                PinListenColorBuilder(blackColor, blackColor),
                          ),
                          codeLength: 6,
                          currentCode: currentCode,
                          onCodeChanged: (code) {
                            if (code.toString().length == 6) {}
                          },
                          cursor: Cursor(
                            width: 2,
                            height: 40,
                            color: Colors.blue,
                            radius: Radius.circular(1),
                            enabled: true,
                          ),
                          key: GlobalKey(),
                          textInputAction: TextInputAction.done,
                          onCodeSubmitted: (String code) {
                            //_otp = code;
                            print("object" + code);
                          }),
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        if (otpcontroller.text.length < 6) {
                          getLoading(context);
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: "+91" + controller.text.toString(),
                            verificationCompleted:
                                (PhoneAuthCredential credential) {
                              print('Verification Completed' +
                                  credential.token.toString());
                            },
                            verificationFailed: (FirebaseAuthException e) {
                              print('Verfification Failed' + e.toString());
                            },
                            // codeSent: (String verificationId, int resendToken) {},
                            codeAutoRetrievalTimeout:
                                (String verificationId) {
                              print("SMS TimeOut");
                            },
                            codeSent:
                                (String id, int? forceResendingToken) async {
                              print("SEND");

                              FirebaseAuth auth = FirebaseAuth.instance;
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: id,
                                      smsCode: otpcontroller.text);

                              await auth.signInWithCredential(credential);

                              print("COMPLETEDDDD");

                              Future.delayed(const Duration(seconds: 0), () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(
                                        // user: user,
                                        ),
                                  ),
                                );
                              });

                              // PhoneAuthCredential credential =
                              //     PhoneAuthProvider.credential(
                              //         verificationId: verificationId,
                              //         smsCode: smsCode);
                              // FirebaseAuth.instance
                              //     .signInWithCredential(credential);
                            },
                          );
                        }
                        if (otpcontroller.text.length == 6) {
                          getLoading(context);
                          FirebaseAuth auth = FirebaseAuth.instance;

                          // FirebaseAuth.instance
                          //     .signInWithCredential(credential);
                        }
                      },
                      child: otpcontroller.text.length == 0
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CardButton(
                                  "SEND OTP",
                                  greencolor,
                                  FaIcon(
                                    FontAwesomeIcons.lock,
                                    color: textcolor,
                                  )),
                            )
                          : CardButton(
                              "VERIFY",
                              greencolor,
                              FaIcon(
                                FontAwesomeIcons.lock,
                                color: textcolor,
                              )))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
