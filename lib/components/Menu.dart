import 'package:flutter/material.dart';
import 'package:rechtslinkstrainer/pages/AboutPage.dart';

class MenuItem {
  const MenuItem({this.title, this.icon});
  final String title;
  final IconData icon;
}

class Menu {
  static const List<MenuItem> menuEntries = const <MenuItem>[
    const MenuItem(title: AboutPage.TITLE, icon: Icons.info)
  ];
}
