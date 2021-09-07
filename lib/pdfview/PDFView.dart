import 'package:dalailalkhayratapp/Screens/bookmark.dart';
import 'package:dalailalkhayratapp/common/global.dart';
import 'package:dalailalkhayratapp/database/db.dart';
import 'package:dalailalkhayratapp/model/bookMark.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../BookMark.dart';

class PDFScreen extends StatefulWidget {
  final String path;
  final String keyPDF;
  late final int resumeco;

  PDFScreen({Key? key, required this.path,required this.resumeco,required this.keyPDF}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();

  var pages = 0;
  // var currentPage = widget.resumeco;
  bool isReady = false;
  String errorMessage = '';


  @override
  void initState() {

    print("resume pg is ");
    print(widget.resumeco);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pdfChapterName[widget.keyPDF]!),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement  (
                    context,
                    MaterialPageRoute(builder: (context) => BookmarkList()),
                  );
                },
                child: Icon(
                  Icons.bookmark,
                  size: 26.0,
                ),
              )
          ),

        ],
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,

            swipeHorizontal: horizontalswip,
            autoSpacing: autospace,
            pageFling: true,
            pageSnap: true,
            defaultPage: widget.resumeco,
            fitPolicy: FitPolicy.BOTH,
            // fitEachPage: true,
            nightMode: nigthmode,
            preventLinkNavigation:
            false, // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages!;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },

            onPageChanged: (int? page, int? total) {
              print('page change: $page/$total');
              setState(() {

                setResumeCount(page!);
                widget.resumeco = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Container()
              : Center(
            child: Text(errorMessage),
          )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              icon: Icon(Icons.bookmark)  ,
              label: Text(""),
              onPressed: () async {
                // await snapshot.data!.setPage(pages ~/ 2);
                String? imgName=resumecount.toString();

                addBookMark(new BookMark(chaptername: imgName,pageId: resumecount,pdfName:resumebook));

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Page "+(resumecount+1).toString()+" book marked."),
                ));
              },
            );
          }

          return Container();
        },
      ),
    );
  }

  Future<void> setResumeCount(int page) async {


    resumecount=page;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('resumecount',page);
    print("resume count set");
    print(page);

  }


}
