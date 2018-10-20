class Comment {
  final String body;
  final List<Comment> replies;
  final String id;
  final String bodyHtml;
  final String subreddit;
  final int created;
  final int ups;
  final int downs;
  final String author;

  Comment(
      {this.body,
      this.replies,
      this.id,
      this.bodyHtml,
      this.subreddit,
      this.created,
      this.ups,
      this.downs,
      this.author});

  Comment.fromJson(Map<String, dynamic> jsonMap)
      : body = jsonMap['body'],
        replies = (jsonMap['replies'] == null || jsonMap['replies'] == '') 
            ? []
            : jsonMap['replies']['data']['children']
                .map<Comment>((child) => Comment.fromJson(child['data']))
                .toList(),
        id = jsonMap['id'],
        bodyHtml = jsonMap['bodyHtml'],
        subreddit = jsonMap['subreddit'],
        created = (jsonMap['created'] ?? 0).toInt(),
        ups = jsonMap['ups'],
        downs = jsonMap['downs'],
        author = jsonMap['author'];
}
