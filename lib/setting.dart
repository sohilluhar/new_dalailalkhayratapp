import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/colors.dart';
import 'common/global.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  String? strnigthmode = "";
  String? strhorizontalswip = "";
  String? strautospace = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kContentColorDarkTheme,
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _buildSwipeOption(),
            Divider(),
            _buildNigthmodeOption(),
            Divider(),
            _buildstrautospaceOption() ,
            Divider(),
            _buildLangOption()
          ],
        ),
      ),
    );
  }

  // Select style enum from dropdown menu:
  Widget _buildSwipeOption() {
    final dropdown = DropdownButton<String>(
      value: strhorizontalswip,
      onChanged: (newval) {
        setState(() {
          strhorizontalswip = newval;
          if (newval == "true") {
            setPref('horizontalswip', true);
            horizontalswip = true;
          } else {
            setPref('horizontalswip', false);
            horizontalswip = false;
          }
        });
      },
      items: [
        DropdownMenuItem(
          value: "true",
          child: Text("Horizontal",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              )),
        ),
        DropdownMenuItem(
          value: "false",
          child: Text("Vertical",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              )),
        ),
      ],
    );

    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      title: Text("Swipe Mode",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          )),
      trailing: dropdown,
    );
  }

  Widget _buildNigthmodeOption() {
    final dropdown = DropdownButton<String>(
      value: strnigthmode,
      onChanged: (newval) {
        setState(() {
          strnigthmode = newval;
          if (newval == "true") {
            setPref('nigthmode', true);
            nigthmode = true;
          } else {
            setPref('nigthmode', false);
            nigthmode = false;
          }
        });
      },
      items: [
        DropdownMenuItem(
          value: "true",
          child: Text("True",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              )),
        ),
        DropdownMenuItem(
          value: "false",
          child: Text("False",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              )),
        ),
      ],
    );

    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      title: Text("Nigth Mode",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          )),
      trailing: dropdown,
    );
  }

  Widget _buildLangOption() {
    final dropdown = DropdownButton<String>(
      value: lang,
      onChanged: (newval) {
        setState(() {
          lang = newval;
setPrefString(newval);
        });
      },
      items: [
        DropdownMenuItem(
          value: "Eng",
          child: Text("English",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              )),
        ),
        DropdownMenuItem(
          value: "Urdu",
          child: Text("Urdu",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              )),
        ),
      ],
    );

    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      title: Text("Language",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          )),
      trailing: dropdown,
    );
  }

  Future<void> setPref(String key, var val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, val);
  }

  Widget _buildstrautospaceOption() {
    final dropdown = DropdownButton<String>(
      value: strautospace,
      onChanged: (newval) {
        setState(() {
          strautospace = newval;
          if (newval == "true") {
            setPref('autospace', true);
            autospace = true;
          } else {
            setPref('autospace', false);
            autospace = false;
          }
        });
      },
      items: [
        DropdownMenuItem(
          value: "true",
          child: Text("True",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              )),
        ),
        DropdownMenuItem(
          value: "false",
          child: Text("False",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              )),
        ),
      ],
    );

    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      title: Text("1pg at Screen on Vertical",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          )),
      trailing: dropdown,
    );
  }

  @override
  void initState() {
    if (nigthmode) {
      strnigthmode = "true";
    } else {
      strnigthmode = "false";
    }
    if (horizontalswip) {
      strhorizontalswip = "true";
    } else {
      strhorizontalswip = "false";
    }
    if (autospace) {
      strautospace = "true";
    } else {
      strautospace = "false";
    }
  }


  Future<void> setPrefString(String? newval) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', newval!);
  }
}
