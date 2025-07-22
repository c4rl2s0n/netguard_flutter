import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class Todo extends StatelessWidget {
  const Todo(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text("TODO: $text", style: context.textTheme.titleMedium.withColor(context.colors.warning),);
  }
}
