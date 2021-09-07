import 'package:dalailalkhayratapp/common/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String? title;
  final bool? showBack;
  final bool? isCenter;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    this.title,
    this.showBack = true,
    this.actions,
    this.isCenter = false,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      leading: showBack!
          ? InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            )
          : null,
      title: Text(
        title!,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: text,
        ),
      ),
      centerTitle: isCenter,
      actions: actions,
      elevation: 0.0,
    );
  }
}
