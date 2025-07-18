import 'dart:math';

import 'package:flutter/material.dart';

import 'package:netguard/common/common.dart';

class SimpleTextField extends StatefulWidget {
  const SimpleTextField({
    this.initialValue = "",
    this.labelText = "",
    this.hintText = "",
    this.validate,
    this.onChanged,
    this.onChangedDelay,
    this.keyboardType = TextInputType.text,
    this.padding,
    this.isPassword = false,
    this.updateWhenInvalid = false,
    this.enabled = true,
    super.key,
  });

  final String labelText;
  final String hintText;
  final String initialValue;
  final String? Function(String?)? validate;
  final Function(String)? onChanged;
  final Duration? onChangedDelay;
  final TextInputType keyboardType;
  final EdgeInsets? padding;
  final bool isPassword;
  final bool updateWhenInvalid;
  final bool enabled;

  @override
  State<SimpleTextField> createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  late TextEditingController controller;
  late bool obscured;

  String? _errorText;
  void _validate() {
    setState(() {
      _errorText = widget.validate?.call(controller.text);
    });
  }

  void _toggleObscure() {
    setState(() {
      obscured = !obscured;
    });
  }

  @override
  void didUpdateWidget(covariant SimpleTextField oldTextField) {
    super.didUpdateWidget(oldTextField);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int cursorPos = controller.selection.baseOffset;
      controller.text = widget.initialValue;
      controller.selection = TextSelection.collapsed(
        offset: min(cursorPos, controller.text.length),
      );
    });
  }

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue);
    obscured = widget.isPassword;
    _validate();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding:
          widget.padding ??
          const EdgeInsets.only(bottom: ThemeConstants.spacing),
      child: TextFormField(
        readOnly: !widget.enabled,
        style: theme.textTheme.bodyLarge,
        controller: controller,
        obscureText: obscured,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          border: widget.enabled ? getTextBoxBorder(context) : null,
          enabledBorder: widget.enabled ? getTextBoxBorder(context) : null,
          focusedBorder: widget.enabled ? getTextBoxBorder(context) : null,
          focusedErrorBorder: getErrorTextBoxBorder(context),
          labelStyle: theme.textTheme.labelLarge?.copyWith(
            color: theme.textTheme.labelLarge?.color?.withOpacity(
              ThemeConstants.lightColorOpacity,
            ),
          ),
          labelText: widget.labelText,
          hintText: widget.hintText,
          errorText: _errorText,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: _toggleObscure,
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: theme.iconTheme.color,
                  ),
                )
              : null,
        ),
        keyboardType: widget.keyboardType,
        onChanged: (val) {
          _validate();
          if (_errorText == null || widget.updateWhenInvalid) {
            Future.delayed(widget.onChangedDelay ?? Duration.zero, () {
              if (widget.onChangedDelay == null ||
                  controller.text == val && context.mounted) {
                widget.onChanged?.call(val);
              }
            });
          }
        },
      ),
    );
  }
}
