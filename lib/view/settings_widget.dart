import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/settings_state.dart';
import 'number_input_widget.dart';

class SettingsWidget extends ConsumerWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsStateProvider);

    return Column(children: [
      const Text("Settings"),
      NumberInputWidget(
        title: 'Min',
        defaultValue: settings.min,
        onChanged: ref.read(settingsStateProvider.notifier).setMin,
      ),
      NumberInputWidget(
        title: 'Max',
        defaultValue: settings.max,
        onChanged: ref.read(settingsStateProvider.notifier).setMax,
      ),
    ]);
  }
}
