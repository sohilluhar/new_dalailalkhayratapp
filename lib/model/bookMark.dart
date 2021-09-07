import 'dart:convert';

class BookMark{
  //imgname is chaptername
  String? chaptername;
  int pageId;
  String? pdfName;

  BookMark({this.chaptername, required this.pageId, this.pdfName});

  factory BookMark.fromJson(Map<String, dynamic> jsonData) {
    return BookMark(

        chaptername: jsonData['chaptername'],
      pageId: jsonData['pageId'],
      pdfName: jsonData['pdfName']
    );
  }

  static Map<String, dynamic> toMap(BookMark bm) => {
    'chaptername': bm.chaptername,
    'pageId': bm.pageId,
    'pdfName': bm.pdfName
  };

  static String encode(List<BookMark> bookmarks) => json.encode(
    bookmarks
        .map<Map<String, dynamic>>((bookmark) => BookMark.toMap(bookmark))
        .toList(),
  );

  static List<BookMark> decode(String bookmarks) =>
      (json.decode(bookmarks) as List<dynamic>)
          .map<BookMark>((item) => BookMark.fromJson(item))
          .toList();
}