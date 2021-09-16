import 'package:dalailalkhayratapp/Widgets/two_side_rounded.dart';
import 'package:dalailalkhayratapp/common/colors.dart';
import 'package:flutter/material.dart';

class CardRead extends StatelessWidget {
  final String? day;
  final String? buttontext;
  final String? chapter;
  final String? pages;
  final GestureTapCallback? press;
  final GestureTapCallback? delete;

  const CardRead(
      {Key? key,
      this.day,
      this.chapter,
      this.pages,
      this.press,
      this.delete,
      this.buttontext = "Read Now"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      height: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        // boxShadow: [
        //   BoxShadow(
        //     offset: Offset(0, 10),
        //     blurRadius: 33,
        //     color: Color(0xFFD3D3D3).withOpacity(.84),
        //   ),
        // ],
      ),
      child: GestureDetector(
        onTap: press,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  left: 24,
                  top: 21,
                  right: size.width * .35,
                ),
                height: MediaQuery.of(context).size.width * 0.2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      day!,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      chapter!,
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                height: 40,
                width: size.width * .3,
                child: TwoSideRoundedButton(
                  text: buttontext,
                  radious: 24,
                  press: press,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 20,
              child: Text(
                pages!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: kLightBlackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
