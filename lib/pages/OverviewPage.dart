import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rechtslinkstrainer/components/Practice.dart';
import 'package:rechtslinkstrainer/pages/AboutPage.dart';

import '../Progress.dart';
import '../DbProvider.dart';
import '../components/Menu.dart';
import '../components/Titlebar.dart';

class OverviewPage extends StatefulWidget {
  static const String TITLE = "Rechts-Links Trainer";
  static const String LINK = "/OverviewPage";
  @override
  OverviewPageState createState() => OverviewPageState();
}

class OverviewPageState extends State<OverviewPage> {
  void onSelected(MenuItem item) {
    switch (item.title) {
      case AboutPage.TITLE:
        Navigator.pushNamed(context, AboutPage.LINK);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(OverviewPage.TITLE),
        actions: <Widget>[
          PopupMenuButton<MenuItem>(
              onSelected: onSelected,
              itemBuilder: (BuildContext context) {
                return Menu.menuEntries.map((MenuItem entry) {
                  return PopupMenuItem<MenuItem>(
                    value: entry,
                    child: Text(entry.title),
                  );
                }).toList();
              })
        ],
      ),
      body: Column(
        children: <Widget>[
          Titlebar(),
          Expanded(
            child: ListView(
                children: practiceList.map((practice) {
              return Card(
                child: ListTile(
                  leading: Icon(practice.icon),
                  title: Text(practice.title),
                  subtitle: FutureBuilder<Progress>(
                    future: DbProvider.db.getProgressByPracticeId(practice.id),
                    builder: (BuildContext context,
                        AsyncSnapshot<Progress> snapshot) {
                      if (snapshot.hasData && snapshot.data.value != null) {
                        return Text(
                            "${snapshot.data.value}% richtige Antworten");
                      } else {
                        return Text("keine Daten vorhanden");
                      }
                    },
                  ),
                  trailing: Icon(Icons.chevron_right),
                  contentPadding: EdgeInsets.all(8),
                  onTap: () {
                    Navigator.pushNamed(context, practice.link);
                  },
                ),
              );
            }).toList()),
          )
        ],
      ),
    );
  }
}
