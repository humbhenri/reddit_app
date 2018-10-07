import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reddit_app/apiservice.dart';
import 'package:reddit_app/user/user.dart';

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
  User _user;

  _HomePageState(this._apiService);

  @override
  void initState() {
    super.initState();
    _getUserInfo();
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
      body: Center(
        child: Text(_user.name),
      ),
    );
  }

  Future<void> _getUserInfo() async {
    final user = await _apiService.me();
    setState(() {
      if (user != null) {
        _user = user;
      }
    });
  }
}
