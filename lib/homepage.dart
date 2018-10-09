import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reddit_app/apiservice.dart';
import 'package:reddit_app/login/loginpage.dart';
import 'package:reddit_app/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  ApiService _apiService;
  User _user;
  _HomePageState();

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
    if (_user == null) {
      return Center(
        child: Container(
          height: 180.0,
          width: 180.0,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('App for Reddit'),
        actions: <Widget>[
          IconButton(
            icon: Image.network(_user.iconImg),
            onPressed: () => {},
          )
        ],
      ),
      body: Center(
        child: Text(_user.name),
      ),
    );
  }

  Future<void> _getUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _apiService = ApiService(prefs.getString('access_token'));
      final user = await _apiService.me();
      setState(() {
        if (user != null) {
          _user = user;
        }
      });
    } catch (AuthorizationException) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()))
          .then((_) => _getUserInfo());
    }
  }
}
