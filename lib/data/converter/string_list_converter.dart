import 'dart:convert';
import 'package:drift/drift.dart';

class StringListConverter with JsonTypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) => List<String>.from(json.decode(fromDb));

  @override
  String toSql(List<String> value) => json.encode(value);
}
