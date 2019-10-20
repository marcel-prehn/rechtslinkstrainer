import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rechtslinkstrainer/pages/OverviewPage.dart';
import 'package:rechtslinkstrainer/pages/AboutPage.dart';
import 'package:rechtslinkstrainer/pages/CubicPracticePage.dart';
import 'package:rechtslinkstrainer/pages/ImagePracticePage.dart';
import 'package:rechtslinkstrainer/pages/TextPracticePage.dart';

void main() {
  var routes = <String, WidgetBuilder>{
    OverviewPage.LINK: (BuildContext context) => new OverviewPage(),
    TextPractice.LINK: (BuildContext context) => new TextPractice(),
    CubicPractice.LINK: (BuildContext context) => new CubicPractice(),
    ImagePractice.LINK: (BuildContext context) => new ImagePractice(),
    AboutPage.LINK: (BuildContext context) => new AboutPage(),
  };

  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: new OverviewPage(),
    debugShowCheckedModeBanner: false,
    routes: routes,
  ));
}
