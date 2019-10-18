import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rechtslinkstrainer/DbProvider.dart';
import 'package:rechtslinkstrainer/Progress.dart';
import 'package:rechtslinkstrainer/practices/CubicPractice.dart';
import 'package:rechtslinkstrainer/practices/TextPractice.dart';

void main() {
  var routes = <String, WidgetBuilder>{
    "/TextPractice": (BuildContext context) => new TextPractice(),
    "/CubicPractice": (BuildContext context) => new CubicPractice(),
  };

  runApp(MaterialApp(
    title: 'Navigation Basics',
    theme: ThemeData.dark(),
    home: new Overview(),
    debugShowCheckedModeBanner: false,
    routes: routes,
  ));
}

getProgress(int practiceId) {
  return DbProvider.db.getProgressByPracticeId(practiceId);
}

class OverviewState extends State<Overview> {

  Widget Titlebar = Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  "Willkommen!",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  "Starte eine Übung, um deine Rechts-Links-Fähigkeiten zu trainieren.",
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rechts-Links Trainer'),
        ),
        body: Column(
          children: <Widget>[
            Titlebar,
            Expanded(
              child: ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.text_format),
                      title: Text("Textuelle Übung"),
                      subtitle: FutureBuilder<Progress>(
                        future: getProgress(TextPractice.PRACTICE_ID),
                        builder: (BuildContext context,
                            AsyncSnapshot<Progress> snapshot) {
                          if (snapshot.hasData && snapshot.data.value != null) {
                            return Text("${snapshot.data.value}% richtige Antworten");
                          } else {
                            return Text("keine Daten vorhanden");
                          }
                        },
                      ),
                      trailing: Icon(Icons.chevron_right),
                      contentPadding: EdgeInsets.all(8),
                      onTap: () {
                        Navigator.pushNamed(context, "/TextPractice");
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.center_focus_strong),
                      title: Text("Kubische Übung"),
                      subtitle: FutureBuilder<Progress>(
                        future: getProgress(CubicPractice.PRACTICE_ID),
                        builder: (BuildContext context,
                            AsyncSnapshot<Progress> snapshot) {
                          if (snapshot.hasData && snapshot.data.value != null) {
                            return Text("${snapshot.data.value}% richtige Antworten");
                          } else {
                            return Text("keine Daten vorhanden");
                          }
                        },
                      ),
                      trailing: Icon(Icons.chevron_right),
                      contentPadding: EdgeInsets.all(8),
                      onTap: () {
                        Navigator.pushNamed(context, "/CubicPractice");
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class Overview extends StatefulWidget {
  @override
  OverviewState createState() => OverviewState();
}
