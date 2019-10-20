import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:rechtslinkstrainer/pages/CubicPracticePage.dart';
import 'package:rechtslinkstrainer/pages/ImagePracticePage.dart';
import 'package:rechtslinkstrainer/pages/TextPracticePage.dart';

class Practice {
  const Practice({this.title, this.id, this.icon, this.link});

  final String title;
  final int id;
  final IconData icon;
  final String link;
}

const List<Practice> practiceList = [
  Practice(
      icon: Icons.text_format,
      title: TextPractice.TITLE,
      id: 1,
      link: TextPractice.LINK),
  Practice(
      icon: Icons.center_focus_strong,
      title: CubicPractice.TITLE,
      id: 2,
      link: CubicPractice.LINK),
  Practice(
      icon: Icons.image,
      title: ImagePractice.TITLE,
      id: 3,
      link: ImagePractice.LINK),
];
