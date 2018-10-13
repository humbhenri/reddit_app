import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reddit_app/apiservice.dart';
import 'package:reddit_app/listings/listing.dart';
import 'package:reddit_app/listings/postlisting.dart';
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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  ApiService _apiService;
  User _user;
  _HomePageState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getUserInfo().then((_) => _getPosts());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _apiService.dispose();
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch (state) {
  //     case AppLifecycleState.paused:
  //       _stopCountTime();
  //       break;
  //     case AppLifecycleState.resumed:
  //       _beginCountTime();
  //       break;
  //     default:
  //       break;
  //   }
  //   super.didChangeAppLifecycleState(state);
  // }

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
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      _getUserInfo();
    }
  }

  Future<void> _getPosts() async {
    final data = await _apiService.mockedBest();
    final posts = Posts.fromJson(data);
    print(posts);
  }
}
