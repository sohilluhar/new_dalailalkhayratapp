import 'package:dalailalkhayratapp/database/db.dart';
import 'package:dalailalkhayratapp/model/bookMark.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


var horizontalswip=true;
var nigthmode=false;
var autospace=true;
var resumecount=0;
var resumebook;
var today_name;
var lang;
List<BookMark> bmList=<BookMark>[];
List<BookMark> idxList=<BookMark>[];

Future<void> loadAll() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  horizontalswip=(prefs.getBool('horizontalswip') ?? true);
  nigthmode=(prefs.getBool('nigthmode') ?? false);
  autospace=(prefs.getBool('autospace') ?? false);

  resumecount=(prefs.getInt('resumecount') ?? 0);
  resumebook=(prefs.getString('resumebook') ?? 'Daily');
  lang=(prefs.getString('lang') ?? 'Eng');
  today_name= DateFormat('EEEE').format(DateTime.now()).toString();
}

Future<List<BookMark>> getBookMark() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();

// Fetch and decode data
  if(prefs.containsKey("bookmarkList")) {
    final String? bookMarkString = await prefs.getString('bookmarkList');

    bmList= BookMark.decode(bookMarkString!);
  }else{
    bmList=<BookMark>[];
  }
 return bmList;
}

Future<List<BookMark>> getIndexMark() async {


  idxList=<BookMark>[];

  for(var key in pdfIndexbookpgno.keys){
    var value=pdfIndexbookpgno[key];
    idxList.add(new BookMark(pageId:int.parse(value!),pdfName: key,chaptername: pdfIndexbookchname[key]));
  }

 return idxList;
}

Future<void> addBookMark(BookMark bmItem) async {
  print("Adding BM");
  print(bmItem.pageId);

SharedPreferences prefs = await SharedPreferences.getInstance();

final List<BookMark> bookMarkList;
// Fetch and decode data
  if(prefs.containsKey("bookmarkList")) {
    final String? bookMarkString = await prefs.getString('bookmarkList');

    bookMarkList= BookMark.decode(bookMarkString!);
  }else{
    bookMarkList=<BookMark>[];
  }

  bookMarkList.add(bmItem);
final String encodedData = BookMark.encode(bookMarkList);
print(encodedData);
await prefs.setString('bookmarkList', encodedData);

}
Future<void> deleteAllBookMark() async {


SharedPreferences prefs = await SharedPreferences.getInstance();

final List<BookMark> bookMarkList=<BookMark>[];
// Fetch and decode data


final String encodedData = BookMark.encode(bookMarkList);
print(encodedData);
await prefs.setString('bookmarkList', encodedData);

}

