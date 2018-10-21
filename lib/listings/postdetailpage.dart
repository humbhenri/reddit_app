import 'package:flutter/material.dart';
import 'package:reddit_app/apiservice.dart';
import 'package:reddit_app/listings/submission.dart';

class PostDetailPage extends StatelessWidget {
  final Submission submission;
  final ApiService apiService;
  const PostDetailPage({Key key, this.submission, this.apiService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postImage = submission.thumbnail == null
        ? Icon(Icons.comment)
        : Image.network(submission.thumbnail);

    final body = Container(
      child: Text(submission.selftext),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(submission.title),
      ),
      body: ListView(
        children: <Widget>[
          postImage,
          body
        ],
      ),
    );
  }
}
