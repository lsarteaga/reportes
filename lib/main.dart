import 'package:flutter/material.dart';
import 'package:reportes/Pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project 3738',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
