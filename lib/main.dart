import 'package:ecommerce/helper/Colors.dart';
import 'package:ecommerce/helper/Constants.dart';
import 'package:ecommerce/helper/authentication.dart';
import 'package:ecommerce/helper/utils.dart';
import 'package:ecommerce/helper/viewmodel.dart';
import 'package:ecommerce/homepage.dart';
import 'package:ecommerce/loginwithPhoneNumber.dart';
import 'package:ecommerce/widgets/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: EcomViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/firebase.png',
              height: 250,
            )),
        Padding(
          padding: const EdgeInsets.only(bottom: 38.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder(
                  future: Authentication.initializeFirebase(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error initializing Firebase');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      print("SUCCESS");
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              getLoading(context);
                              User? user =
                                  await Authentication.signInWithGoogle(
                                      context: context);
                              if (user != null) {
                                Navigator.pop(context);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(
                                        // user: user,
                                        ),
                                  ),
                                );
                              }
                            },
                            child: CardButton(
                                "GOOGLE",
                                googleButtonColor,
                                FaIcon(
                                  FontAwesomeIcons.google,
                                  color: textcolor,
                                )),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginWithNumber(
                                      // user: user,
                                      ),
                                ),
                              );
                            },
                            child: CardButton(
                                "PHONE",
                                greencolor,
                                FaIcon(
                                  FontAwesomeIcons.phoneAlt,
                                  color: textcolor,
                                )),
                          ),
                        ],
                      );
                    }
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        greencolor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
