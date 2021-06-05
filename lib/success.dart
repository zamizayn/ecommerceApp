import 'package:ecommerce/helper/Colors.dart';
import 'package:ecommerce/helper/viewmodel.dart';
import 'package:ecommerce/homepage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  void initState() {
    super.initState();
    Provider.of<EcomViewModel>(context, listen: false).clearAll();
    new Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textcolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/check.json',
              height: 200,
              repeat: false,
              fit: BoxFit.fill,
            ),
            Text(
              "Order Placed Successfully",
              style: TextStyle(color: blackColor, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
