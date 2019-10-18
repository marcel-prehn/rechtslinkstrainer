import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uuid/uuid.dart';

import '../DbProvider.dart';
import '../Result.dart';

class CubicPractice extends StatefulWidget {
  static const PRACTICE_ID = 2;
  CubicPractice({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CubicPracticeState();
}

enum CubicSide { OBEN_LINKS, OBEN_RECHTS, UNTEN_LINKS, UNTEN_RECHTS }

class CubicPracticeState extends State<CubicPractice> {
  static const TEXT_OBEN_LINKS = "Oben links";
  static const TEXT_OBEN_RECHTS = "Oben rechts";
  static const TEXT_UNTEN_LINKS = "Unten links";
  static const TEXT_UNTEN_RECHTS = "Unten rechts";
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

  String shuffle() {
    var random = new Random();
    var nextValue = random.nextInt(99);
    if (nextValue % 5 == 0) {
      correctSide = CubicSide.OBEN_LINKS;
      return TEXT_OBEN_LINKS;
    } else if (nextValue % 3 == 0) {
      correctSide = CubicSide.OBEN_RECHTS;
      return TEXT_OBEN_RECHTS;
    } else if (nextValue % 2 == 0) {
      correctSide = CubicSide.UNTEN_LINKS;
      return TEXT_UNTEN_LINKS;
    } else {
      correctSide = CubicSide.UNTEN_RECHTS;
      return TEXT_UNTEN_RECHTS;
    }
  }

  onButtonPressed(CubicSide side) {
    if (side == correctSide) {
      setState(() {
        correctAnswers++;
        bottomBarColor = Colors.green[200];
        bottomTextColor = Colors.grey[850];
      });
    } else {
      setState(() {
        incorrectAnswers++;
        bottomBarColor = Colors.red[200];
        bottomTextColor = Colors.grey[850];
      });
    }
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
                onPressed: () async {
                  var uuid = new Uuid();
                  Result res = new Result(
                      uuid: uuid.v4(),
                      practiceId: CubicPractice.PRACTICE_ID,
                      timestamp: DateTime.now().toIso8601String(),
                      correct: correctAnswers,
                      incorrect: incorrectAnswers
                      );
                  await DbProvider.db.saveResult(res);
                  Navigator.popUntil(context, ModalRoute.withName("/"));
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
            title: Text("Kubische Übung"),
          ),
          body: Builder(builder: (BuildContext context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  color: Colors.grey[800],
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16),
                  child: Text(shuffle(),
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                ),
                Expanded(
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/Cubic_Center.png"),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 50,
                          child: GestureDetector(
                            onTap: () => onButtonPressed(CubicSide.OBEN_LINKS),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/Cubic_Corner.png"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          top: 50,
                          child: GestureDetector(
                            onTap: () => onButtonPressed(CubicSide.OBEN_RECHTS),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/Cubic_Corner.png"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 50,
                          child: GestureDetector(
                            onTap: () => onButtonPressed(CubicSide.UNTEN_LINKS),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/Cubic_Corner.png"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          bottom: 50,
                          child: GestureDetector(
                            onTap: () =>
                                onButtonPressed(CubicSide.UNTEN_RECHTS),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/Cubic_Corner.png"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: bottomBarColor,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Korrekte Anworten: $correctAnswers/${correctAnswers + incorrectAnswers}",
                    style: TextStyle(color: bottomTextColor),
                  ),
                ),
              ],
            );
          }),
        ),
        onWillPop: () {
          showConfirmationDialog(context);
          return new Future.value(false);
        });
  }
}
