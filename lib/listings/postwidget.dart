import 'package:flutter/material.dart';
import 'package:reddit_app/apiservice.dart';
import 'package:reddit_app/listings/post.dart';
import 'package:reddit_app/listings/linkpage.dart';
import 'package:reddit_app/listings/postlisting.dart';
import 'package:reddit_app/listings/link.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          post.title,
          style: TextStyle(fontSize: 20.0, color: Colors.deepOrange),
        ),
        subtitle: Text(
          '${post.author} - [${post.subreddit}] - 💬${post.numComments}',
          style: TextStyle(fontSize: 16.0),
        ),
        leading: post.thumbnail == null
            ? null
            : Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.orange),
                borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              margin: EdgeInsets.all(4.0),
              child: Image.network(
                  post.thumbnail,
                  width: 120.0,
                  height: 70.0,
                  alignment: Alignment(-1.0, -1.0),
                  fit: BoxFit.cover,
                ),
            ),
        onTap: () => showPostDetail(context));
  }

  showPostDetail(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final apiService = ApiService(token);
    final data = await ApiService(token).comments(post.id);
    final link = Link.fromJson(data);
    print(data);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LinkPage(
                  link: link,
                  apiService: apiService,
                )));
  }
}

class PostListingWidget extends StatelessWidget {
  final Posts posts;

  const PostListingWidget({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.posts.length,
      itemBuilder: (context, index) {
        return Column(children: <Widget>[
          Divider(
            height: 5.0,
          ),
          PostWidget(post: posts.posts[index]),
        ]);
      },
    );
  }
}
