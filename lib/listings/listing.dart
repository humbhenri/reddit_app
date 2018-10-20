class Listing {
  final String after;
  final String before;
  final int limit;
  final int count;
  final String show;
  final int dist;
  final List<dynamic> children;

  Listing.fromJson(Map<String, dynamic> jsonMap)
      : after = jsonMap['data']['after'],
        before = jsonMap['data']['before'],
        limit = jsonMap['data']['limit'],
        count = jsonMap['data']['count'],
        show = jsonMap['data']['show'],
        dist = jsonMap['data']['dist'],
        children = jsonMap['data']['children'];
}
