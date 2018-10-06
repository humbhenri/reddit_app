import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String code;

  HomePage(this.code);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Welcome'),);
  }
}
