import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:reddit_app/home.dart';
import 'package:reddit_app/randomstring.dart';
import 'package:reddit_app/secretloader.dart';

const redirectUri = 'http://www.github.com/humbhenri/reddit_app';
const scope = 'identity,mysubreddits,read,save,submit,subscribe,edit';
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
const authURL =
    'https://www.reddit.com/api/v1/authorize.compact?response_type=code&'
    'redirect_uri=$redirectUri&duration=temporary&scope=$scope';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _flutterWebviewPlugin = new FlutterWebviewPlugin();
  String _code;

  String _randomString;

  StreamSubscription<String> _onUrlChanged;

  _LoginPageState() {
    _randomString = new RandomString(10).string;
  }

  @override
  void initState() {
    super.initState();
    _onUrlChanged = _flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        print('Url changed: $url');
        final uri = Uri.dataFromString(url);
        print('Uri query segment ${uri.queryParameters}');
        final query = uri.queryParameters;
        if (query['state'] == _randomString && query.containsKey('code')) {
          print('Auth successful');
          _code = query['code'];
          _flutterWebviewPlugin.close();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePage(_code)));
        }
      }
    });
  }

  Future<void> _launchAuthUrl() async {
    Secret secret =
        await SecretLoader(secretPath: 'assets/secrets.json').load();
    String url = authURL + '&client_id=${secret.apiKey}&state=$_randomString';
    _flutterWebviewPlugin.launch(
      url,
      withJavascript: true,
      userAgent: kAndroidUserAgent,
      rect: Rect.fromLTWH(0.0, 0.0, MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
    );
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reddit login'),
      ),
      body: Center(
        child: Container(
            width: 250.0,
            padding: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  _launchAuthUrl();
                },
                child: Text('Login with Reddit'),
              ),
            )),
      ),
    );
  }
}
