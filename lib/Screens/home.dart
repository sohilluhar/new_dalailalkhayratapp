import 'dart:async';
import 'dart:io';

import 'package:dalailalkhayratapp/Widgets/gridscroll.dart';
import 'package:dalailalkhayratapp/Widgets/customAppbar.dart';

import 'package:dalailalkhayratapp/Widgets/read_card.dart';

import 'package:dalailalkhayratapp/common/colors.dart';
import 'package:dalailalkhayratapp/common/colors.dart';
import 'package:dalailalkhayratapp/common/global.dart';
import 'package:dalailalkhayratapp/database/db.dart';
import 'package:dalailalkhayratapp/pdfview/PDFView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../BookMark.dart';
import '../setting.dart';
import 'bookmark.dart';
import 'index.dart';
import 'index.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void loadFile(var bookkey) async {
    var con;
    var filename = pdfbook[bookkey];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('resumebook', bookkey);
    if (resumebook != bookkey)
      con = 0;
    else
      con = resumecount;
    resumebook = bookkey;
    await fromAsset('assets/pdf/' + filename!, filename + '.pdf').then((f) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PDFScreen(
                  path: f.path,
                  resumeco: con,
                  keyPDF: bookkey,
                )),
      ).then(refreshScreen);
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kContentColorDarkTheme,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomAppBar(
            title: appname[lang]!,
            showBack: false,
            actions: [
              IconButton(
                icon: Icon(Icons.format_list_bulleted),
                tooltip: "Index",
                onPressed: () {
                  print("index");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IndexList()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.bookmark),
                tooltip: "Bookmark List",
                onPressed: () {
                  print("bookmark");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookmarkList()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.settings),
                tooltip: "Setting",
                onPressed: () {
                  print("Setting");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  ).then(refreshScreen);
                },
              ),
            ],
          ),
          SliverPadding(
            padding: Platform.isIOS
                ? const EdgeInsets.symmetric(horizontal: 20)
                : const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: size.height * 0.03),

              if(lang!="Urdu")
                  TextHeading("Today", "Reading"),
              if(lang=="Urdu")
                TextHeading("آج", "پڑھیں"),

              if(lang!="Urdu")
                    CardRead(
                        day: today_name,
                        chapter: pdfChapterName[today_name],
                        pages: pdfbookCount[today_name]! + " Pages",
                        press: () {
                          loadFile(today_name);
                        }),
                  if (lang == "Urdu")
                    CardRead(
                        day: pdfKeyUrdu[today_name],
                        chapter: pdfChapterNameUrdu[today_name],
                pages: pdfbookCount[today_name]! + " صفحہ ",
                        press: () {
                          loadFile(today_name);
                        }),
              if(lang!="Urdu")
                  TextHeading("Resume", "Reading"),
              if(lang=="Urdu")
                TextHeading("جاری", "پڑھیں"),

                  continueReading(size, resumebook, pdfChapterName[resumebook],
                      pdfbookCount[resumebook]),


              if(lang!="Urdu")
                  TextHeading("Daily", "Reading"),
              if(lang=="Urdu")
              TextHeading("روزانہ", "پڑھیں"),
              if(lang!="Urdu")
                  CardRead(
                      day: "Daily",
                      chapter: "Daily",
                      pages: "22 Pages",
                      press: () {
                    loadFile('Daily');
                      }),
              if(lang=="Urdu")
                CardRead(
                  day: "روزانہ",
                  chapter: "روزانہ",
                  pages: "22 صفحہ",
                  press: () {
                    loadFile('Daily');
                  }),
              if(lang!="Urdu")
                  TextHeading("Weekday", "Reading"),
              if(lang=="Urdu")

                TextHeading("ہفتے", "پڑھیں"),
                  WeeklyScroll(),
              if(lang!="Urdu")
              TextHeading("More", "Reading"),
              if(lang=="Urdu")
                TextHeading("مزید", "پڑھیں"),
                  OtherScroll(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget WeeklyScroll() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: <Widget>[
            for (var key in pdfweekbook.keys)...[

              if(lang!="Urdu" && key!='Daily')
              ReadingListCard(
                image: "assets/image/0.jpg",
                title: key,
                page: pdfbookCount[key]! + " Pages",
                pressRead: () {
                  loadFile(key);
                },
              ),
              if (lang=="Urdu" && key!='Daily')
                ReadingListCard(
                  image: "assets/image/0.jpg",
                  title: pdfKeyUrdu[key],
                  page: pdfbookCount[key]! + " صفحہ ",
                  pressRead: () {
                    loadFile(key);
                  },
                ),
            ]
          ],
        ),
      ),
    );
  }


  Widget OtherScroll() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: <Widget>[
            for (var key in pdfOtherbook.keys)...[
              if(lang!="Urdu")
              ReadingListCard(
                image: "assets/image/0.jpg",
                title: key,
                page: pdfbookCount[key]! + " Pages",
                pressRead: () {
                  loadFile(key);
                },
              ),
             if (lang=="Urdu")
              ReadingListCard(
                image: "assets/image/0.jpg",
                title: pdfKeyUrdu[key],
                page: pdfbookCount[key]! + " صفحہ ",
                pressRead: () {
                  loadFile(key);
                },
              ),]
          ],
        ),
      ),
    );
  }

  GestureDetector continueReading(
      Size size, String? day_name, String? chapter_name, String? total) {
    var resume;
    if (resumebook != day_name)
      resume = 0;
    else
      resume = resumecount;
    String keyname=day_name.toString();


    return GestureDetector(
        onTap: () {
          loadFile(day_name);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          height: MediaQuery.of(context).size.width * 0.25,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9),
            // boxShadow: [
            //   BoxShadow(
            //     offset: Offset(0, 10),
            //     blurRadius: 33,
            //     color: Color(0xFFD3D3D3).withOpacity(.84),
            //   ),
            // ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 24),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if(lang!="Urdu")
                          Text(
                            day_name!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                          if(lang=="Urdu")
                            Text(
                              pdfKeyUrdu[day_name]!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontSize:
                                MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),

                          SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if(lang!="Urdu")
                              Text(
                                chapter_name!,
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                              ),
                              if(lang=="Urdu")
                                Text(
                                  pdfChapterNameUrdu[day_name]!,
                                  style: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                  ),
                                ),
                              if(lang!="Urdu")
                              Text(
                                "Page " +
                                    (resume + 1).toString() +
                                    " of " +
                                    total!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kLightBlackColor,
                                ),
                              ),
                              if(lang=="Urdu")
                                Text(
                                  "صفحات " +
                                      (resume + 1).toString() +
                                      " - " +
                                      total!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: kLightBlackColor,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 7,
                  width: size.width *
                      (int.parse(resume.toString()) / int.parse(total!)),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  FutureOr refreshScreen(value) {
    setState(() {});
  }
}
