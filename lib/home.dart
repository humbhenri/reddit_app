import 'package:flutter/material.dart';
import 'package:reddit_app/apiservice.dart';

class HomePage extends StatefulWidget {
  final String _code;

  HomePage(this._code);

  @override
  _HomePageState createState() {
    return _HomePageState(ApiService(_code));
  }
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService;

  _HomePageState(this._apiService);

  @override
  void initState() {
    super.initState();
    _apiService.me();
  }

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App for Reddit'),
      ),
      body: Center(),
    );
  }
}
