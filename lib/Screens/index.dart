import 'dart:async';
import 'dart:io';

import 'package:dalailalkhayratapp/Widgets/customAppbar.dart';
import 'package:dalailalkhayratapp/Widgets/read_card.dart';
import 'package:dalailalkhayratapp/common/colors.dart';
import 'package:dalailalkhayratapp/common/global.dart';
import 'package:dalailalkhayratapp/database/db.dart';
import 'package:dalailalkhayratapp/model/bookMark.dart';
import 'package:dalailalkhayratapp/pdfview/PDFView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexList extends StatefulWidget {


  @override
  State<IndexList> createState() => _IndexListState();
}

class _IndexListState extends State<IndexList> {


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Index",
        showBack: true,
        actions: [

        ],
      ),
      backgroundColor: kContentColorDarkTheme,
      body:

      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
    child:
    FutureBuilder<List<BookMark>>(

    future: bmData,
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      return
      GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24),
      // scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: snapshot.data!.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    childAspectRatio: MediaQuery.of(context).size.width /
    (MediaQuery.of(context).size.height / 5),
    crossAxisCount: 1),
    itemBuilder: (context, index) {
        return  CardRead(
                    day: snapshot.data![index].chaptername,
                    chapter:"",
                    pages: "",
                    delete: () {
                    },
                    press: () {gotoBookMark(snapshot.data![index]);},
                  );
    }
    );

    }
    return Center(child: CircularProgressIndicator());
    })

      ),
    );
  }

  var bmData;
  @override
  void initState() {
    bmData=getIndexMark();
  }


  Future<void> gotoBookMark(var bm) async {



    await fromAsset('assets/pdf/prebook.pdf','prebook.pdf').then((f) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PDFScreen(path: f.path,resumeco: bm.pageId,keyPDF: bm.pdfName,)),
      );
    });

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



}
