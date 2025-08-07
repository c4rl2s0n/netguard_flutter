import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class Todo extends StatelessWidget {
  const Todo(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TInfo("TODO: $text");
  }
}
