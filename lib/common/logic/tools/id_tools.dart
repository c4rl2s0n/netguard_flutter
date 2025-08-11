import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';

class IdTools {
  static String generateUuid() {
    return const Uuid().v4();
  }
  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
