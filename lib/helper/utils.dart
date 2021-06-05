import 'package:ecommerce/helper/Colors.dart';
import 'package:ecommerce/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void getLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          color: textcolor,
          height: 200,
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new CircularProgressIndicator(
                color: greencolor,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Loading , Please Wait...",
                  style: TextStyle(color: blackColor),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

void FireBaseLogin(String number, String otp, BuildContext context) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: "+91" + number,
    verificationCompleted: (PhoneAuthCredential credential) {
      print('Verification Completed' + credential.token.toString());
    },
    verificationFailed: (FirebaseAuthException e) {
      print('Verfification Failed' + e.toString());
    },
    // codeSent: (String verificationId, int resendToken) {},
    codeAutoRetrievalTimeout: (String verificationId) {
      print("SMS TimeOut");
    },
    codeSent: (String id, int? forceResendingToken) async {
      print("SEND");

      // currentCode = '259957';
      FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: id, smsCode: otp);

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
