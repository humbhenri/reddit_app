import 'package:flutter/material.dart';
import 'package:reddit_app/listings/submission.dart';

class PostDetailPage extends StatelessWidget {

  final Submission submission;
  const PostDetailPage({Key key, this.submission}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text(submission.title),
    ),);
  }
}