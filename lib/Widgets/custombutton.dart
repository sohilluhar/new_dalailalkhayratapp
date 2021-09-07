import 'package:dalailalkhayratapp/common/colors.dart';
import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final String? title;
//   final GestureTapCallback? action;
//
//   const CustomButton({Key? key, this.title, this.action}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(
//         bottom: 15,
//       ),
//       child: SizedBox(
//         width: double.infinity,
//         child: FlatButton(
//           onPressed: action!,
//           child: Text(
//             title!,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontFamily: text,
//               fontSize: 18,
//               color: Colors.white
//             ),
//           ),
//           color: kPrimaryColor,
//           textColor: Theme.of(context).textTheme.bodyText1!.color,
//           shape: new RoundedRectangleBorder(
//             borderRadius: new BorderRadius.circular(6.0),
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//         ),
//       ),
//     );
//   }
// }

class RoundedButton extends StatelessWidget {
  final String? text;
  final GestureTapCallback? press;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? fontSize;

  RoundedButton({
    Key? key,
    this.text,
    this.press,
    this.verticalPadding = 16,
    this.horizontalPadding = 30,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 16),
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding!, horizontal: horizontalPadding!),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 30,
              color: Color(0xFF666666).withOpacity(.11),
            ),
          ],
        ),
        child: Text(
          text!,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
