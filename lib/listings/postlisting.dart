import 'package:reddit_app/listings/listing.dart';
import 'package:reddit_app/listings/post.dart';

class Posts {
  final List<Post> posts;

  Posts.fromJson(Map<String, dynamic> jsonMap)
      : posts = Listing.fromJson(jsonMap)
            .children
            .map((data) => Post.fromJson(data['data']))
            .toList();
}
