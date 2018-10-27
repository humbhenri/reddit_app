import 'package:reddit_app/listings/comments.dart';
import 'package:reddit_app/listings/post.dart';

class Link extends Post {
  final List<Comment> comments;
  final String selftext;

  Link.fromJson(List<dynamic> jsonMap)
      : comments = jsonMap[1]['data']['children']
            .map<Comment>((child) => Comment.fromJson(child['data']))
            .toList(),
        selftext = jsonMap[0]['data']['children'][0]['data']['selftext'],
        super.fromJson(jsonMap[0]['data']['children'][0]['data']);
}
