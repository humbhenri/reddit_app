import 'package:reddit_app/listings/image.dart';

class Post {
  final String id;
  final String name;
  final String subreddit;
  final String author;
  final String title;
  final int score;
  final List<Image> preview;
  final String _thumbnail;
  final int numComments;
  final double created;

  Post.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        name = jsonMap['name'],
        subreddit = jsonMap['subreddit'],
        author = jsonMap['author'],
        score = jsonMap['score'],
        title = jsonMap['title'],
        preview = jsonMap['preview'] != null
            ? jsonMap['preview']['images'][0]['resolutions']
                .map<Image>((image) => Image.fromJson(image))
                .toList()
            : [],
        _thumbnail = jsonMap['thumbnail'],
        numComments = jsonMap['num_comments'],
        created = jsonMap['created']
        ;
  String get thumbnail {
    return !_thumbnail.startsWith('http') ? null : _thumbnail;
  }
}
