class Image {
  final String url;
  final double width;
  final double height;

  Image({this.url, this.width, this.height});

  Image.fromJson(Map<String, dynamic> jsonMap)
      : url = jsonMap['url'],
        width = jsonMap['width'].toDouble(),
        height = jsonMap['height'].toDouble();
}
