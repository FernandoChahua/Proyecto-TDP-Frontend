import 'dart:convert';

import 'package:crypto/crypto.dart';

abstract class ImageGeneratonr {
  static const userProfile =
      "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y&s=128";

  static String getImage(String username) {
    final id = md5.convert(utf8.encode(username)).toString();
    return "https://www.gravatar.com/avatar/$id?d=identicon&f=y&s=128";
  }

  static String getBotImage(String username) {
    final id = md5.convert(utf8.encode(username)).toString();
    return "https://www.gravatar.com/avatar/$id?d=robohash&f=y&s=128";
  }
}
