import 'dart:async';
import 'dart:io';
import 'package:dalailalkhayratapp/Widgets/chapter_card.dart';
import 'package:dalailalkhayratapp/Widgets/customAppbar.dart';
import 'package:dalailalkhayratapp/common/colors.dart';
import 'package:dalailalkhayratapp/database/db.dart';
import 'package:dalailalkhayratapp/pdfview/PDFView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class IndexList extends StatefulWidget {
  @override
  State<IndexList> createState() => _IndexListState();
}

class _IndexListState extends State<IndexList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
      body: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
        CustomAppBar(
          title: "Content",
          showBack: true,
          actions: [],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: Platform.isIOS
                ? const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
                : const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextHeading("Beginning", "Reading"),
                SizedBox(height: 15),
                for (var key in pdfIndexbookpgno.keys)
                  ChapterCard(
                    name: pdfIndexbookchname[key],
                    pages: pdfIndexbookpgno[key]! + " Page",
                    press: () {
                      gotoIndex(key);
                    },
                  ),
                ChapterCard(
                  name: "Daily",
                  pages: "Total 22 Pages",
                  press: () {
                    gotoBookMark('Daily');
                  },
                ),
                TextHeading("Weekday", "Reading"),
                SizedBox(height: 15),
                for (String key in pdfweekbook.keys)
                  if (key != 'Daily')
                    ChapterCard(
                      name: key,
                      pages: "Total " + pdfbookCount[key]! + " Pages",
                      press: () {
                        gotoBookMark(key);
                      },
                    ),
                TextHeading("Other", "Reading"),
                SizedBox(height: 15),
                for (String key in pdfOtherbook.keys)
                  ChapterCard(
                    name: key,
                    pages: "Total " + pdfbookCount[key]! + " Pages",
                    press: () {
                      gotoBookMark(key);
                    },
                  ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> gotoBookMark(String key) async {
    var filename = pdfbook[key];

    await fromAsset('assets/pdf/' + filename!, filename + '.pdf').then((f) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PDFScreen(
                  path: f.path,
                  resumeco: 0,
                  keyPDF: key,
                )),
      );
    });
  }

  Future<void> gotoIndex(String key) async {
    var filename = pdfbook[key];

    await fromAsset('assets/pdf/' + filename!, filename + '.pdf').then((f) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PDFScreen(
                  path: f.path,
                  resumeco: int.parse(pdfIndexbookpgno[key]!) - 1,
                  keyPDF: key,
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
