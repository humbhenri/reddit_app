import 'package:reddit_app/listings/comments.dart';
import 'package:reddit_app/listings/post.dart';

class Submission extends Post {
  final List<Comment> comments;

  Submission.fromJson(List<dynamic> jsonMap)
      : comments = jsonMap[1]['data']['children']
            .map<Comment>((child) => Comment.fromJson(child['data']))
            .toList(),
        super.fromJson(jsonMap[0]['data']['children'][0]['data']);
}
