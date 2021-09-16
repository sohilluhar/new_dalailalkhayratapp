import 'package:flutter/material.dart';

import '../common/colors.dart';
import '../common/colors.dart';
import '../common/colors.dart';

class ChapterCard extends StatelessWidget {
  final String? name;
  final String? pages;
  final String? chapterNumber;
  final GestureTapCallback? press;
  final GestureTapCallback? delete;
  const ChapterCard({
    Key? key,
    this.name,
    this.pages,
    this.chapterNumber,
    this.press,
    this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.only(top: 15, left: 30, bottom: 15, right: 15),
        margin: EdgeInsets.only(bottom: 15),
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(0, 10),
          //     blurRadius: 33,
          //     color: Color(0xFFD3D3D3).withOpacity(.84),
          //   ),
          // ],
        ),
        child: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${name == null ? "" : name} ${name == null || chapterNumber == null ? "" : ":"} ${chapterNumber == null ? "" : chapterNumber}",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  pages!,
                  style: TextStyle(color: kLightBlackColor, fontSize: 12),
                ),
              ],
            ),
            // RichText(
            //   text: TextSpan(
            //     children: [
            //       TextSpan(
            //         text: "$chapterNumber : $name \n",
            //         style: TextStyle(
            //           color: kPrimaryColor,
            //           fontWeight: FontWeight.bold,
            //           fontSize: MediaQuery.of(context).size.width * 0.040,
            //         ),
            //       ),
            //       TextSpan(
            //         text: pages,
            //         style: TextStyle(color: kLightBlackColor, fontSize: 12),
            //       ),
            //     ],
            //   ),
            // ),
            Spacer(),
            IconButton(
              icon: Icon(
                delete == null
                    ? Icons.arrow_forward_ios_outlined
                    : Icons.delete,
                size: 18,
                color: delete == null ? kSecondaryColor : Colors.redAccent,
              ),
              onPressed: delete == null ? press : delete,
            ),
          ],
        ),
      ),
    );
  }
}
