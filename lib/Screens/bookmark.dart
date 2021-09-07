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

class BookmarkList extends StatefulWidget {


  @override
  State<BookmarkList> createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Bookmark",
        showBack: true,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.bookmark),
          //   onPressed: () {
          //     print("bookmark");
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => BookmarkList()),
          //     );
          //   },
          // ),
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
                    day: snapshot.data![index].pdfName,
                    chapter: pdfChapterName[snapshot.data![index].pdfName],
                    pages: "Resume "+pdfbookCount[snapshot.data![index].pdfName]!+" page",
                    delete: () {
                      deleteBookMark(index);
                    },
                    press: () {gotoBookMark(snapshot.data![index]);},
                  );
    }
    );

    }
    return Center(child: CircularProgressIndicator());
    })
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 24),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //
    //           CardRead(
    //             day: "Monday",
    //             chapter: "Chapter Name",
    //             pages: "10 pages",
    //             delete: () {},
    //             press: () {},
    //           ),
    //           CardRead(
    //             day: "Monday",
    //             chapter: "Chapter Name",
    //             pages: "10 pages",
    //             delete: () {},
    //             press: () {},
    //           ),
    //           CardRead(
    //             day: "Monday",
    //             chapter: "Chapter Name",
    //             pages: "10 pages",
    //             delete: () {},
    //             press: () {},
    //           ),
    //           CardRead(
    //             day: "Monday",
    //             chapter: "Chapter Name",
    //             pages: "10 pages",
    //             delete: () {},
    //             press: () {},
    //           ),
    //           CardRead(
    //             day: "Monday",
    //             chapter: "Chapter Name",
    //             pages: "10 pages",
    //             delete: () {},
    //             press: () {},
    //           ),
    //           CardRead(
    //             day: "Monday",
    //             chapter: "Chapter Name",
    //             pages: "10 pages",
    //             delete: () {},
    //             press: () {},
    //           ),
    //           CardRead(
    //             day: "Monday",
    //             chapter: "Chapter Name",
    //             pages: "10 pages",
    //             delete: () {},
    //             press: () {},
    //           ),
    //         ],
    //       ),
    //     ),
      ),
    );
  }

  var bmData;
  @override
  void initState() {
    bmData=getBookMark();
  }


  Future<void> gotoBookMark(var bm) async {

    var filename=pdfbook[bm.pdfName];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('resumebook', bm.pdfName);

    await fromAsset('assets/pdf/'+filename!, filename+'.pdf').then((f) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PDFScreen(path: f.path,resumeco: resumecount,keyPDF: bm.pdfName,)),
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

  Future<void> deleteBookMark(var index) async {
    print("Removing BM");
    // print(.pageId);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<BookMark> bookMarkList;
// Fetch and decode data
    if(prefs.containsKey("bookmarkList")) {
      final String? bookMarkString = await prefs.getString('bookmarkList');

      bookMarkList= BookMark.decode(bookMarkString!);
    }else{
      bookMarkList=<BookMark>[];
    }

    bookMarkList.removeAt (index);
    final String encodedData = BookMark.encode(bookMarkList);
    print(encodedData);
    await prefs.setString('bookmarkList', encodedData);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Bookmark deleted."),
    ));
    setState(() {
      bmData=getBookMark();
    });
  }


}
