class User {
  final String name;

  const User({this.name});

  User.fromJson(Map<String, dynamic> jsonMap)
    : name = jsonMap['name'];
}