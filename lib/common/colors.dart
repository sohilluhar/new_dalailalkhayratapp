import 'package:flutter/material.dart';

//colors
const kPrimaryColor = Color(0xff38A3A5);
const kSecondaryColor = Color(0xff22577A);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xffF3F1F5);
const kBackground = Color(0xffF3F1F5);

const kBlackColor = Color(0xFF393939);
const kLightBlackColor = Color(0xFF8F8F8F);
const kIconColor = Color(0xFFF48A37);
const kProgressIndicator = Color(0xFFBE7066);
final kShadowColor = Color(0xFFD3D3D3).withOpacity(.84);

//padding
const kDefaultPadding = 20.0;

//font
const heading = "PlayfairDisplay";
const text = "Karla";

// //Widget
//Heading
Widget TextHeading(String text1, text2) {
  return RichText(
    text: TextSpan(
      style: TextStyle(
        color: kBlackColor,
      ),
      children: [
        TextSpan(
          text: "$text1 ",
          style: TextStyle(
            color: kPrimaryColor,
            // fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        TextSpan(
          text: text2,
          style: TextStyle(
            color: kSecondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        )
      ],
    ),
  );
}

//Button
