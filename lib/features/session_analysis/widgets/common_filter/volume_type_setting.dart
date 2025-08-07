import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/widgets/settings/simple_setting.dart';
import 'package:netguard/data/models/enums.dart';
import 'package:netguard/features/features.dart';

class VolumeTypeSetting extends StatelessWidget {
  const VolumeTypeSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
      buildWhen: (oldState, state) => oldState.volumeType != state.volumeType,
      builder: (context, state) => SimpleSetting(
        name: "Traffic Volume Type",
        description: "Show traffic volume in count of bytes",
        action: DropdownMenu<VolumeType>(
          initialSelection: state.volumeType,
          requestFocusOnTap: false,
          onSelected: (v) => v != null
              ? context.read<SessionLogAnalysisCubit>().setVolumeType(v)
              : null,
          dropdownMenuEntries: VolumeType.values
              .map(
                (d) => DropdownMenuEntry<VolumeType>(
                  value: d,
                  label: d.toString(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
