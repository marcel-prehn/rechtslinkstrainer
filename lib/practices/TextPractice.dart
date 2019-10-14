import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rechtslinkstrainer/DbProvider.dart';
import 'package:rechtslinkstrainer/Result.dart';
import 'package:uuid/uuid.dart';

enum Side { LEFT, RIGHT }

class TextPractice extends StatefulWidget {
  static const PRACTICE_ID = 1;
  TextPractice({Key key}) : super(key: key);
  @override
  TextPracticeState createState() => TextPracticeState();
}

class TextPracticeState extends State<TextPractice> {
  static const String TEXT_LEFT = "Links wählen";
  static const String TEXT_RIGHT = "Rechts wählen";
  static const String TEXT_ERROR = "Da ist ein Fehler aufgetreten...";
  static const String TEXT_CORRECT = "Das war richtig!";
  static const String TEXT_INCORRECT = "Das war leider falsch...";
  static const int DURATION = 200;
  Side correctSide;
  int correctAnswers = 0;
  int incorrectAnswers = 0;

  String shuffle() {
    var random = new Random();
    var nextValue = random.nextInt(999);
    if (nextValue % 2 == 0) {
      correctSide = Side.LEFT;
      return TEXT_LEFT;
    }
    correctSide = Side.RIGHT;
    return TEXT_RIGHT;
  }

  onButtonPressed(BuildContext context, Side selectedSide) {
    debugPrint("correct side: $correctSide, selected side: $selectedSide");
    if (selectedSide == null) {
      displayError(context);
    } else if (selectedSide == correctSide) {
      countCorrectAnswer();
      displayCorrectAnswer(context);
    } else {
      countIncorrectAnswer();
      displayIncorrectAnswer(context);
    }
  }

  void displayError(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(TEXT_ERROR),
      action: SnackBarAction(
        label: "Wiederholen",
        onPressed: () {
          shuffle();
        },
      ),
    ));
  }

  void displayCorrectAnswer(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(TEXT_CORRECT),
      duration: Duration(milliseconds: DURATION),
      backgroundColor: Colors.green[200],
    ));
    setState(() {
    });
  }

  void displayIncorrectAnswer(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(TEXT_INCORRECT),
      duration: Duration(milliseconds: DURATION),
      backgroundColor: Colors.red[200],
    ));
    setState(() {
    });
  }

  void countCorrectAnswer() {
    correctAnswers++;
  }

  void countIncorrectAnswer() {
    incorrectAnswers++;
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
                      practiceId: TextPractice.PRACTICE_ID,
                      timestamp: DateTime.now().toIso8601String(),
                      correct: correctAnswers,
                      incorrect: incorrectAnswers);
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
            title: Text("Textuelle Übung"),
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
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Container(
                          height: double.infinity,
                          child: FlatButton(
                              child: null,
                              color: Colors.grey[200],
                              onPressed: () {
                                onButtonPressed(context, Side.LEFT);
                              }),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          height: double.infinity,
                          child: FlatButton(
                              child: null,
                              color: Colors.grey[300],
                              onPressed: () {
                                onButtonPressed(context, Side.RIGHT);
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[800],
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16),
                  child: Text(
                      "Korrekte Anworten: $correctAnswers / ${correctAnswers + incorrectAnswers}"),
                ),
              ],
            );
          })),
      onWillPop: () {
        showConfirmationDialog(context);
        return new Future.value(false);
      },
    );
  }
}
