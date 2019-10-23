import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatelessWidget {
  static const String TITLE = "Über die App";
  static const String LINK = "/AboutPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TITLE),
      ),
      body: Builder(builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text("Recht-Links Trainer"),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text("Version 1.1.5"),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text("Marcel Prehn 2019"),
                )
              ],
            )
          ],
        );
      }),
    );
  }
}
