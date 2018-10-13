class Post {
  final String id;
  final String name;
  final String subreddit;
  final String author;
  final int score;

  Post({this.id, this.name, this.subreddit, this.author, this.score});


  Post.fromJson(Map<String, dynamic> jsonMap)
    : id = jsonMap['id']
    , name = jsonMap['name']
    , subreddit = jsonMap['subreddit']
    , author = jsonMap['author']
    , score = jsonMap['score'];

}