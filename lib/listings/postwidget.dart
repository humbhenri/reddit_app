import 'package:flutter/material.dart';
import 'package:reddit_app/listings/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(post.name),);
  }

}