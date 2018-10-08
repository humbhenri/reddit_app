import 'dart:math';

const ALPHA = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

class RandomString {
  String string;

  RandomString(int length) {
    string = String.fromCharCodes(List.generate(length, (index) {
      final rand = new Random();
      return ALPHA.codeUnitAt(rand.nextInt(ALPHA.length));
    }));
  }
}