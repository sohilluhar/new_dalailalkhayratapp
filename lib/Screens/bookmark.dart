import 'dart:async';
import 'dart:io';
import 'package:dalailalkhayratapp/Widgets/chapter_card.dart';
import 'package:dalailalkhayratapp/Widgets/customAppbar.dart';
import 'package:dalailalkhayratapp/common/colors.dart';
import 'package:dalailalkhayratapp/common/global.dart';
import 'package:dalailalkhayratapp/database/db.dart';
import 'package:dalailalkhayratapp/model/bookMark.dart';
import 'package:dalailalkhayratapp/pdfview/PDFView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/colors.dart';

class BookmarkList extends StatefulWidget {
  @override
  State<BookmarkList> createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var titlestr='';
    if(lang!='Urdu')
      titlestr='Bookmarks';
    else
      titlestr='نشانی ';
    return Scaffold(
      backgroundColor: kContentColorDarkTheme,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomAppBar(
            title: titlestr,
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
          SliverPadding(
            padding: Platform.isIOS
                ? const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
                : const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height - 80,
                child: FutureBuilder<List<BookMark>>(
                    future: bmData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            shrinkWrap: false,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              if (lang != "Urdu")
                                return ChapterCard(
                                  name: snapshot.data![index].pdfName,
                                  chapterNumber: pdfChapterName[
                                      snapshot.data![index].pdfName],

                                  pages: (snapshot.data![index].pageId + 1)
                                          .toString() +
                                      " Page ",
                                  // "/"+ pdfChapterName[snapshot.data![index].pdfName]+" ",
                                  delete: () {
                                    deleteBookMark(index);
                                  },
                                  press: () {
                                    gotoBookMark(snapshot.data![index]);
                                  },
                                );
                              if (lang == "Urdu")
                                return ChapterCard(
                                  name:
                                      pdfKeyUrdu[snapshot.data![index].pdfName],
                                  chapterNumber: pdfChapterNameUrdu[
                                      snapshot.data![index].pdfName],

                                  pages: (snapshot.data![index].pageId + 1)
                                          .toString() +
                                      " مزید ",
                                  // "/"+ pdfChapterName[snapshot.data![index].pdfName]+" ",
                                  delete: () {
                                    deleteBookMark(index);
                                  },
                                  press: () {
                                    gotoBookMark(snapshot.data![index]);
                                  },
                                );
                              return SizedBox.shrink();
                            });
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  var bmData;
  @override
  void initState() {
    bmData = getBookMark();
  }

  Future<void> gotoBookMark(var bm) async {
    var filename = pdfbook[bm.pdfName];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('resumebook', bm.pdfName);

    await fromAsset('assets/pdf/' + filename!, filename + '.pdf').then((f) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PDFScreen(
                  path: f.path,
                  resumeco: resumecount,
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

  Future<void> deleteBookMark(var index) async {
    print("Removing BM");
    // print(.pageId);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<BookMark> bookMarkList;
// Fetch and decode data
    if (prefs.containsKey("bookmarkList")) {
      final String? bookMarkString = await prefs.getString('bookmarkList');

      bookMarkList = BookMark.decode(bookMarkString!);
    } else {
      bookMarkList = <BookMark>[];
    }

    bookMarkList.removeAt(index);
    final String encodedData = BookMark.encode(bookMarkList);
    print(encodedData);
    await prefs.setString('bookmarkList', encodedData);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Bookmark deleted."),
    ));
    setState(() {
      bmData = getBookMark();
    });
  }
}
