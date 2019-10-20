import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rechtslinkstrainer/pages/OverviewPage.dart';

class ImagePractice extends StatefulWidget {
  static const String TITLE = "Bildliche Übung";
  static const String LINK = "/ImagePractice";
  static const PRACTICE_ID = 3;
  ImagePractice({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ImagePracticeState();
}

class ImagePracticeState extends State<ImagePractice> {
  var correctSide;
  var correctAnswers;
  var incorrectAnswers;
  var bottomBarColor;
  var bottomTextColor;

  @override
  void initState() {
    super.initState();
    correctAnswers = 0;
    incorrectAnswers = 0;
    bottomBarColor = Colors.grey[800];
    bottomTextColor = Colors.white;
  }

  showConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Beenden"),
            content: Text("Willst du die Übung beenden?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Abbrechen"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Beenden"),
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(OverviewPage.LINK));
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(ImagePractice.TITLE),
          ),
          body: Builder(builder: (BuildContext context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            );
          }),
        ),
        onWillPop: () {
          return new Future.value(true);
        });
  }
}
