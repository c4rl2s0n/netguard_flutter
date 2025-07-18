import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class InfoContainerActionButton extends StatelessWidget {
  const InfoContainerActionButton({
    this.icon,
    this.text,
    this.enabled = true,
    this.onTap,
    this.loading = false,
    this.color,
    super.key,
  });

  final Icon? icon;
  final String? text;
  final bool enabled;
  final Function()? onTap;
  final bool loading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconTextButton(
      icon: icon,
      text: text,
      enabled: enabled,
      loading: loading,
      onTap: onTap,
      color: color,
      verticalPadding: 2,
    );
  }
}
