import 'package:uuid/uuid.dart';

class IdTools {
  static String generateUuid() {
    return const Uuid().v4();
  }
}
