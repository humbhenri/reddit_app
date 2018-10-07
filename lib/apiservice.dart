import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:reddit_app/apiconfig.dart';
import 'package:reddit_app/exceptions.dart';
import 'package:reddit_app/useragentclient.dart';

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
    _client = _AuthUserAgentClient(UserAgentClient(ApiConfig.USER_AGENT, http.Client()), _token);
  }

  void dispose() {
    _client.close();
  }

  Future<dynamic> me() async {
    final response = await _client.get(
      ApiConfig.ROOT_URI + '/api/v1/me',
    );
    switch (response.statusCode) {
      case 200:
        print('Oauth successful');
        print(response.body);
        break;
      case 401:
        throw AuthorizationException();
        break;
    }
  }
}
