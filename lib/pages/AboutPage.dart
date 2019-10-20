import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatelessWidget {
  static const String TITLE = "Über die App";
  static const String LINK = "/AboutPage";
  getPackageInfo() {
    var versionInfo = new Map();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      versionInfo["appName"] = packageInfo.appName;
      versionInfo["packageName"] = packageInfo.packageName;
      versionInfo["version"] = packageInfo.version;
      versionInfo["buildNumber"] = packageInfo.buildNumber;
    });
    return versionInfo;
  }

  @override
  Widget build(BuildContext context) {
    var versionInfo = getPackageInfo();
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
                  child: Text("App-Version: ${versionInfo["version"]}"),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text("Buildnummer: ${versionInfo["buildNumber"]}"),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text("test"),
                )
              ],
            )
          ],
        );
      }),
    );
  }
}
