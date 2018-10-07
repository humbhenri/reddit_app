class User {
  final String name;
  final String iconImg;

  const User({this.name, this.iconImg});

  String toString() {
    return 'User[name = $name, iconImg = $iconImg]';
  }

  User.fromJson(Map<String, dynamic> jsonMap)
    : name = jsonMap['name'],
    iconImg = jsonMap['icon_img'];
}