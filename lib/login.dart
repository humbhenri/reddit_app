import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username;
  String _password;
  final _formKey = GlobalKey<FormState>();

  String _notEmpty(String value) {
    if (value.isEmpty) {
      return 'Cannot be empty';
    }
    return null;
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
          child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    validator: _notEmpty,
                    decoration: InputDecoration(
                      labelText: 'User name',
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: _notEmpty,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // do login
                        }
                      },
                      child: Text('Submit'),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
