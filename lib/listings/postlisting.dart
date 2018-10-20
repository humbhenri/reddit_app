import 'package:reddit_app/listings/listing.dart';
import 'package:reddit_app/listings/post.dart';

class Posts extends Listing {
  List<Post> _posts;

  Posts.fromJson(Map<String, dynamic> jsonMap) : super.fromJson(jsonMap) {
    _posts = children.map((child) => Post.fromJson(child['data'])).toList();
  }

  List<Post> get posts => _posts;

}
