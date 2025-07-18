import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: "Theme Settings",
      settings: [_darkMode(context), _colorScheme()],
    );
  }

  Widget _darkMode(BuildContext context) {
    return SimpleSetting(
      name: "Dark Mode",
      action: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (oldState, state) => oldState.darkMode != state.darkMode,
        builder: (context, state) {
          return Switch(
            value: state.darkMode,
            onChanged: (_) => context.read<SettingsCubit>().toggleDarkMode(),
          );
        },
      ),
    );
  }

  Widget _colorPreview(
    BuildContext context,
    bool darkMode,
    FlexScheme colorScheme, {
    double size = 25,
  }) => Theme(
    data: getTheme(darkMode, flexScheme: colorScheme),
    child: Builder(
      builder: (context) => Row(
        children: [
          Container(width: size, height: size, color: context.colors.primary),
          Container(width: size, height: size, color: context.colors.secondary),
          Container(width: size, height: size, color: context.colors.tertiary),
        ],
      ),
    ),
  );
  Widget _colorScheme() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (oldState, state) =>
          oldState.colorScheme != state.colorScheme ||
          oldState.darkMode != state.darkMode,
      builder: (context, state) {
        return SimpleSetting(
          name: "Color Scheme",
          description: "Select a color scheme",
          action: DropdownMenu<FlexScheme>(
            key: Key(state.colorScheme.name),
            initialSelection: state.colorScheme,
            requestFocusOnTap: false,
            onSelected: (c) =>
                c != null ? context.settings.setColorScheme(c) : null,
            leadingIcon: _colorPreview(
              context,
              state.darkMode,
              state.colorScheme,
            ),
            dropdownMenuEntries: FlexScheme.values
                .map(
                  (d) => DropdownMenuEntry<FlexScheme>(
                    value: d,
                    label: d.name,
                    leadingIcon: _colorPreview(context, state.darkMode, d),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
