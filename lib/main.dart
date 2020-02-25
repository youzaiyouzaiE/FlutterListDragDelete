
import 'package:expanded_sample/pags/tab_bar_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final String _title = 'List View Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: tabBar(),
    );
  }
}

Widget tabBar() {
  return TabBarPage();
}