import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reddit_app/apiconfig.dart';
import 'package:reddit_app/exceptions.dart';
import 'package:reddit_app/user/user.dart';
import 'package:reddit_app/useragentclient.dart';
import 'package:flutter/services.dart' show rootBundle;
class _AuthUserAgentClient extends http.BaseClient {
  final String _token;
  final http.Client _inner;

  _AuthUserAgentClient(this._inner, this._token);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = 'bearer $_token';
    return _inner.send(request);
  }
}

class ApiService {
  // bearer token
  final String _token;

  _AuthUserAgentClient _client;

  ApiService(this._token) {
    _client = _AuthUserAgentClient(
        UserAgentClient(ApiConfig.USER_AGENT, http.Client()), _token);
  }

  void dispose() {
    _client.close();
  }

  Future<User> me() async {
    final response = await _client.get(
      ApiConfig.ROOT_URI + '/api/v1/me',
    );
    final data = _handleResponse(response);
    if (data != null) {
      return User.fromJson(data);
    }
    return null;
  }

  Future<dynamic> best() async => _get('/best');

  Future<dynamic> mockedBest() async {
    final String best = await rootBundle.loadString('assets/best.json');
    return json.decode(best);
  }

  Future<dynamic> _get(String path) async {
    final response = await _client.get(ApiConfig.ROOT_URI + path);
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response res) {
    switch (res.statusCode) {
      case 200:
        return json.decode(res.body);
        break;
      case 401:
        throw AuthorizationException();
        break;
      default:
        return null;
    }

  }
}
