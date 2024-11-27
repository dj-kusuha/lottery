import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottery/state/history_state.dart';
import 'package:lottery/state/roulette_state.dart';
import 'package:lottery/view/history_widget.dart';

import 'state/settings_state.dart';
import 'view/settings_widget.dart';

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
        body: const Column(children: [
          Row(children: [
            SettingsWidget(),
            ButtonTest(),
          ]),
          Expanded(
            child: HistoryWidget(),
          ),
        ]),
      ),
    );
  }
}

// NOTE: 抽選をしてヒストリーに追加していくのを表示するテスト
// このあと最大値を入力できるようにしたり、ボックスガチャになるように修正していく
// ボックスガチャは、抽選対象番号をリストに用意してその中で抽選したあと、
// 抽選された番号をリストから消していけばよいだろう
class ButtonTest extends HookConsumerWidget {
  const ButtonTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsStateProvider);
    final roulette = ref.watch(rouletteStateProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            '${roulette.value}',
            style: TextStyle(
              color: roulette.isSpinning ? Colors.grey : Colors.blue,
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: roulette.isSpinning
                ? null
                : () async {
                    final result =
                        await ref.read(rouletteStateProvider.notifier).spin(
                              Duration(seconds: settings.rouletteSeconds),
                            );
                    ref.read(historyStateProvider.notifier).add(result);
                  },
            child: const Text('抽選する'),
          ),
        ],
      ),
    );
  }
}
