import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

class HostsEditDialog extends StatelessWidget {
  const HostsEditDialog({required this.rule, super.key});

  final Rule rule;
  String get title => rule.name.empty ? "Edit Rule" : rule.name!;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: title,
      icon: Icon(CustomIcons.edit),
      content: SingleChildScrollView(child: Text("content", softWrap: true)),
      actions: const [ConfirmButton()],
      expand: false,
    );
  }

  Widget _hosts(){
    return SizedBox();
  }

  static Future<List<HostEntry>?> show(
    BuildContext context, {
    required Rule rule,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => HostsEditDialog(rule: rule),
    );
  }
}
