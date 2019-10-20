import 'package:flutter/material.dart';

class Titlebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}
