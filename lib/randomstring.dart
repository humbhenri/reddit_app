import 'dart:math';

const ASCII_START = 65;
const ASCII_END = 122;

class RandomString {
  String string;

  RandomString(int length) {
    string = String.fromCharCodes(List.generate(length, (index) {
      final rand = new Random();
      return ((ASCII_END - ASCII_START) * rand.nextDouble()).toInt() + ASCII_START;
    }));
  }
}