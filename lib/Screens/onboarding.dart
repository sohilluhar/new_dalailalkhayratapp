import 'dart:io';
import 'package:dalailalkhayratapp/Screens/home.dart';
import 'package:dalailalkhayratapp/common/colors.dart';
import 'package:flutter/material.dart';

class SliderModel {
  String imgpath;
  String title;
  String des;

  SliderModel({required this.imgpath, required this.title, required this.des});

  void setImagePath(String getImg) {
    imgpath = getImg;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDes(String getDes) {
    des = getDes;
  }

  String setImagePath1() {
    return imgpath;
  }

  String setTitle1() {
    return title;
  }

  String setDes1() {
    return des;
  }
}

List<SliderModel> getSlide() {
  List<SliderModel> slides = <SliderModel>[];
  SliderModel sliderM = new SliderModel(title: '', imgpath: '', des: '');
  //1
  sliderM.setImagePath('image/loginbg.png');
  sliderM.setTitle('Heading');
  sliderM.setDes('Description');
  slides.add(sliderM);
  sliderM = new SliderModel(title: '', imgpath: '', des: '');
  //2
  sliderM.setImagePath('image/loginbg.png');
  sliderM.setTitle('Broadcast Activity');
  sliderM.setDes('Your event is broadcast to the Chalo Community');
  slides.add(sliderM);
  sliderM = new SliderModel(title: '', imgpath: '', des: '');
  //3
  sliderM.setImagePath('image/loginbg.png');
  sliderM.setTitle('Enjoy your Activity');
  sliderM.setDes(
      'Enjoy your Activity when someone accepts and the activity begins!!');
  slides.add(sliderM);
  return slides;
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<SliderModel> slide = <SliderModel>[];
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);
  @override
  void initState() {
    slide = getSlide();
    // print('inside onboarding');
    super.initState();
  }

  Widget pageDot(bool isCurrent) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrent ? 10.0 : 6.0,
      width: isCurrent ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrent ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: pageController,
          itemCount: slide.length,
          onPageChanged: (val) {
            setState(() {
              currentIndex = val;
            });
          },
          itemBuilder: (context, index) {
            return SliderTile(
              img: slide[index].setImagePath1(),
              title: slide[index].setTitle1(),
              des: slide[index].setDes1(),
            );
          }),
      bottomSheet: currentIndex != slide.length - 1
          ? Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              height: Platform.isIOS ? 70 : 60,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(slide.length - 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.linear);
                    },
                    child: Text('SKIP'),
                  ),
                  Row(
                    children: <Widget>[
                      for (int i = 0; i < slide.length; i++)
                        currentIndex == i ? pageDot(true) : pageDot(false)
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(currentIndex + 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.linear);
                    },
                    child: Text('NEXT'),
                  ),
                ],
              ),
            )
          : Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              alignment: Alignment.center,
              height: Platform.isIOS ? 70 : 60,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                child: Text(
                  'Start Reading',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
    );
  }
}

class SliderTile extends StatelessWidget {
  final String img, title, des;
  SliderTile({required this.img, required this.title, required this.des});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                img,
                width: 350.0,
                height: 350.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                des,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
