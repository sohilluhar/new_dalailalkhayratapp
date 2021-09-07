import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dalailalkhayratapp/pdfview/PDFView.dart';
import 'package:dalailalkhayratapp/setting.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/global.dart';
import 'database/db.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {

String pathPDF="";
final ButtonStyle style =
ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
@override
void initState() {
  loadAll();

}
  @override
  Widget build(BuildContext context) {
    return  Scaffold( appBar: AppBar(
      title: Text("App"),
    ),
        body:
        Center(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            for(String key in pdfbook.keys)

           ElevatedButton(
              style: style,
              onPressed: (){
                loadFile(key);
            },
              child:  Text(key+" Book "),
            ),


            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },child: Text("Setting"),

            ),  TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: (){
                deleteAllBookMark();
            },child: Text("Clear BookMark"),

            ),

            // MaterialButton(
            //     child: ,
            //     onPressed:() {})
          ],))
    );
  }

  Future<File> fromAsset(String asset, String filename) async {
  // To open from assets, you can copy them to the app storage folder, and the access them "locally"
  Completer<File> completer = Completer();

  try {
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/$filename");
    var data = await rootBundle.load(asset);
    var bytes = data.buffer.asUint8List();
    await file.writeAsBytes(bytes, flush: true);
    completer.complete(file);
  } catch (e) {
    print(e);
    throw Exception('Error parsing asset file!');
  }

  return completer.future;
}



void loadFile(var bookkey) async {
  var con;
  var filename=pdfbook[bookkey];

  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('resumebook', bookkey);
  if(resumebook!=bookkey)
    con=0;
  else
    con=resumecount;
  resumebook=bookkey;
  await fromAsset('assets/pdf/'+filename!, filename+'.pdf').then((f) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PDFScreen(path: f.path,resumeco: con,keyPDF: resumebook,)),
    );
  });


}

}
