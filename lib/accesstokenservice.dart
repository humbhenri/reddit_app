import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:reddit_app/apiconfig.dart';
import 'package:reddit_app/exceptions.dart';
import 'dart:convert';

import 'package:reddit_app/secretloader.dart';

class AccessTokenService {
  final String _code;

  AccessTokenService(this._code);

  Future<String> retrieve() async {
    final response = await http.post(ApiConfig.ACCESS_TOKEN_URI, body: {
      'grant_type': 'authorization_code',
      'code': _code,
      'redirect_uri': ApiConfig.REDIRECT_URI
    }, headers: {
      'Authorization': 'Basic ${await _encode()}'
    });
    print('Access Token: ${response.reasonPhrase}, headers = ${response.request.headers}, body = ${response.body}');
    if (response.statusCode == 401) {
      throw AuthorizationException();
    }
    final data = json.decode(response.body);
    return data['access_token'];
  }

  Future<String> _encode() async {
    final secret = await SecretLoader(secretPath: 'assets/secrets.json').load();
    return base64.encode(utf8.encode(secret.apiKey + ':'));
  }
}
