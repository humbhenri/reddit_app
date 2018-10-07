import 'package:http/http.dart' as http;
import 'dart:async';

class UserAgentClient extends http.BaseClient {
  final String _userAgent;
  final http.Client _inner;

  UserAgentClient(this._userAgent, this._inner);

  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers['user-agent'] = _userAgent;
    http.StreamedResponse res = await _inner.send(request);
    print('HTTP request = ${res.request.url} , status = ${res.statusCode}');
    print('HTTP headers = ${res.request.headers}');
    print('HTTP reasonPhrase = ${res.reasonPhrase}');
    return res;
  }

}