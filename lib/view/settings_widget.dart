import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/settings_state.dart';
import 'number_input_widget.dart';

class SettingsWidget extends ConsumerWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsStateProvider);

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.all(10),
        color: const Color.fromARGB(255, 219, 239, 255),
        child: Column(
          children: [
            const Text(
              "設定",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                NumberInputWidget(
                  title: '最小',
                  defaultValue: settings.min,
                  onChanged: ref.read(settingsStateProvider.notifier).setMin,
                ),
                NumberInputWidget(
                  title: '最大',
                  defaultValue: settings.max,
                  onChanged: ref.read(settingsStateProvider.notifier).setMax,
                ),
                NumberInputWidget(
                  title: '結果が出るまでの秒数',
                  defaultValue: settings.rouletteSeconds,
                  onChanged: ref
                      .read(settingsStateProvider.notifier)
                      .setRouletteSeconds,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
