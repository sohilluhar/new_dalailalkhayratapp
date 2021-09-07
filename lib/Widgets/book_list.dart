import 'package:dalailalkhayratapp/Widgets/two_side_rounded.dart';
import 'package:dalailalkhayratapp/common/colors.dart';
import 'package:flutter/material.dart';

class ReadingListCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? page;

  final GestureTapCallback? pressDetails;
  final GestureTapCallback? pressRead;

  const ReadingListCard({
    Key? key,
    this.image,
    this.title,
    this.page,
    this.pressDetails,
    this.pressRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 7),
            blurRadius: 6,
            color: kShadowColor,
          ),
        ],
      ),
      margin: EdgeInsets.only(right: 24, bottom: 40),
      height: 215,
      width: 202,
      child: Stack(
        children: <Widget>[
          Image.asset(
            image!,
            width: 100,
            fit: BoxFit.contain,
            // height: 40,
          ),
          Positioned(
            top: 160,
            child: Container(
              height: 60,
              width: 202,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: Text(
                        title!,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      )),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 101,
                        padding: EdgeInsets.symmetric(vertical: 0),
                        alignment: Alignment.center,
                        child: Text(
                          page!,
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TwoSideRoundedButton(
                          text: "Read",
                          press: pressRead,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}