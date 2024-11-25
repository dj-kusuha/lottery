import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottery/state/settings_state.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.emoji_emotions_outlined),
          title: const Text('抽選くん'),
        ),
        body: Row(children: [
          const SettingsWidget(),
          ButtonTest(),
        ]),
      ),
    );
  }
}

class SettingsWidget extends HookConsumerWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsStateProvider);
    final minController =
        useTextEditingController(text: settings.min.toString());
    final maxController =
        useTextEditingController(text: settings.max.toString());

    return Column(
      children: [
        const Text("Settings"),
        Row(
          children: [
            const Text('min'),
            const SizedBox(width: 10),
            SizedBox(
              width: 200,
              child: TextField(
                controller: minController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  final min = int.tryParse(value);
                  if (min != null) {
                    ref.read(settingsStateProvider.notifier).setMin(min);
                  }
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text('max'),
            const SizedBox(width: 10),
            SizedBox(
              width: 200,
              child: TextField(
                controller: maxController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  final max = int.tryParse(value);
                  if (max != null) {
                    ref.read(settingsStateProvider.notifier).setMax(max);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// NOTE: 抽選をしてヒストリーに追加していくのを表示するテスト
// このあと最大値を入力できるようにしたり、ボックスガチャになるように修正していく
// ボックスガチャは、抽選対象番号をリストに用意してその中で抽選したあと、
// 抽選された番号をリストから消していけばよいだろう
class ButtonTest extends HookConsumerWidget {
  final _random = Random();

  ButtonTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = useState(0);
    final history = useState(<int>[]);

    final settings = ref.watch(settingsStateProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            '${count.value}',
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final range = settings.max - settings.min + 1;
              count.value = _random.nextInt(range) + settings.min;
              history.value = [count.value, ...history.value];
            },
            child: const Text('抽選する'),
          ),
          const Text('当選履歴'),
          Text(_generateHistoryText(history.value)),
        ],
      ),
    );
  }

  String _generateHistoryText(List<int> history) {
    final buf = StringBuffer();
    for (final value in history) {
      buf.write(value);
      buf.writeln();
    }
    return buf.toString();
  }
}
