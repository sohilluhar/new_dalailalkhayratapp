import 'dart:async';
import 'dart:io';

import 'package:dalailalkhayratapp/model/bookMark.dart';
import 'package:dalailalkhayratapp/pdfview/PDFView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/global.dart';
import 'database/db.dart';



class BookMarkUI extends StatefulWidget {
  const BookMarkUI({Key? key}) : super(key: key);

  @override
  _BookMarkUI createState() => _BookMarkUI();
}

class _BookMarkUI extends State<BookMarkUI> {

  var bmData;
  @override
  void initState() {
    bmData=getBookMark();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text("BookMarks"),
        ),
        body:

        SingleChildScrollView(

        child:
        FutureBuilder<List<BookMark>>(
          future: bmData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  // scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 4),
                      crossAxisCount: 1),
                  itemBuilder: (context, index) {
                    return Padding(

                        padding: EdgeInsets.all(5),
                        child:
                        GestureDetector(
                            onTap: () {
                              gotoBookMark(snapshot.data![index]);
                            },
                    child:
                        Container(

                            decoration: new BoxDecoration(

                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                    image:

                                        new  AssetImage(
                                            "assets/image/"+
                                                snapshot.data![index].chaptername!
                                        // "8.jpg"
                                        )


                                    )
                        )))
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          },
        ),



          // FutureBuilder(
          //     future: bmData,
          //     builder: (ctx, snapshot) {
          //       if (snapshot.hasData) {
          //         return  Column(
          //           children: [
          //
          //             for (var i in bmList)
          //               getBookMarkListUI(i)
          //
          //           ],
          //         );
          //       }
          //       else {
          //         return
          //         Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: <Widget>[
          //               CircularProgressIndicator()
          //             ]
          //         );                }
          //     }
          // )

        )

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


  Future<void> gotoBookMark(var bm) async {

    var filename=pdfbook[bm.pdfName];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('resumebook', bm.pdfName);

    await fromAsset('assets/pdf/'+filename!, filename+'.pdf').then((f) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PDFScreen(path: f.path,resumeco: resumecount,keyPDF:bm.pdfName ,)),
      );
    });

  }




}




