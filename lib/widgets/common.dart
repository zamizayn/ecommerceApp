import 'package:ecommerce/helper/Colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget getButtonContainer(String name, FaIcon icon) {
  return Container();
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

Card CardButton(String text, Color buttoncolor, FaIcon icon) {
  return Card(
    color: buttoncolor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40), // if you need this
      side: BorderSide(
        color: Colors.grey.withOpacity(0.2),
        width: 1,
      ),
    ),
    child: Container(
      height: 50,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: IconButton(onPressed: () {}, icon: icon),
          ),
          Expanded(
              flex: 8,
              child: Center(
                  child: Text(
                text,
                style: TextStyle(color: textcolor, fontWeight: FontWeight.bold),
              ))),
          Expanded(
            flex: 2,
            child: Container(),
          )
        ],
      ),
    ),
  );
}
