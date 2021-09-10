import 'dart:async';
import 'dart:io';

import 'package:dalailalkhayratapp/Widgets/chapter_card.dart';
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
        title: "Content",
        showBack: true,
        actions: [],
      ),
      backgroundColor: kContentColorDarkTheme,
      // body: Container(
      //   height: MediaQuery.of(context).size.height - 80,
      //   child: FutureBuilder<List<BookMark>>(
      //       future: bmData,
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData) {
      //           return ListView.builder(
      //               physics: const BouncingScrollPhysics(
      //                   parent: AlwaysScrollableScrollPhysics()),
      //               padding: const EdgeInsets.symmetric(
      //                   horizontal: 24, vertical: 20),
      //               shrinkWrap: false,
      //               itemCount: snapshot.data!.length,
      //               itemBuilder: (context, index) {
      //                 return ChapterCard(
      //                   name: snapshot.data![index].chaptername,
      //                   chapterNumber: "2",
      //                   pages: "20 Pages",
      //                   press: () {
      //                     gotoBookMark(snapshot.data![index]);
      //                   },
      //                 );
      //               });
      //         }
      //         return Center(child: CircularProgressIndicator());
      //       }),
      // ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextHeading("Begining", "Reading"),
              SizedBox(height: 15),
              ChapterCard(
                name: "Chapter 1",
                pages: "Total 20 Pages",
                press: () {},
              ),
              ChapterCard(
                name: "Chapter 2",
                pages: "Total 20 Pages",
                press: () {},
              ),
              ChapterCard(
                name: "Chapter 3",
                pages: "Total 20 Pages",
                press: () {},
              ),
              ChapterCard(
                name: "Chapter 4",
                pages: "Total 20 Pages",
                press: () {},
              ),
              ChapterCard(
                name: "Daily",
                pages: "Total 20 Pages",
                press: () {},
              ),
              TextHeading("Weekday", "Reading"),
              SizedBox(height: 15),
              ChapterCard(
                name: "Monday",
                pages: "Total 20 Pages",
                press: () {},
              ),
              ChapterCard(
                name: "Tuesday",
                pages: "Total 20 Pages",
                press: () {},
              ),
              ChapterCard(
                name: "Wednesday",
                pages: "Total 20 Pages",
                press: () {},
              ),
              ChapterCard(
                name: "Thursday",
                pages: "Total 20 Pages",
                press: () {},
              ),
              ChapterCard(
                name: "Friday",
                pages: "Total 20 Pages",
                press: () {},
              ),
              ChapterCard(
                name: "Saturday",
                pages: "Total 20 Pages",
                press: () {},
              ),
              ChapterCard(
                name: "Sunday",
                pages: "Total 20 Pages",
                press: () {},
              ),
              TextHeading("Other", "Reading"),
              SizedBox(height: 15),
              ChapterCard(
                name: "Sunday",
                pages: "Total 20 Pages",
                press: () {},
              ),
              ChapterCard(
                name: "Sunday",
                pages: "Total 20 Pages",
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  var bmData;
  @override
  void initState() {
    bmData = getIndexMark();
  }

  Future<void> gotoBookMark(var bm) async {
    await fromAsset('assets/pdf/prebook.pdf', 'prebook.pdf').then((f) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PDFScreen(
                  path: f.path,
                  resumeco: bm.pageId,
                  keyPDF: bm.pdfName,
                )),
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
