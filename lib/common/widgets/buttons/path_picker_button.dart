import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class PathPickerButton extends StatelessWidget {
  const PathPickerButton({
    this.dialogTitle = "Select a filepath",
    required this.onPathSelected,
    super.key,
  });

  final String dialogTitle;
  final Function(String path) onPathSelected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        String? selectedPath = await FilePicker.platform.getDirectoryPath(
          dialogTitle: dialogTitle,
        );
        if (!context.mounted) return;
        if (selectedPath.notEmpty) {
          onPathSelected(selectedPath!);
        }
      },
      icon: const Icon(CustomIcons.pickFile),
    );
  }
}
