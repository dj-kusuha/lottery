import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MainApp());
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
        body: const Center(
          child: ButtonTest(),
        ),
      ),
    );
  }
}

// NOTE: 抽選をしてヒストリーに追加していくのを表示するテスト
// このあと最大値を入力できるようにしたり、ボックスガチャになるように修正していく
// ボックスガチャは、抽選対象番号をリストに用意してその中で抽選したあと、
// 抽選された番号をリストから消していけばよいだろう
class ButtonTest extends HookWidget {
  const ButtonTest({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final count = useState(0);
    final history = useState(<int>[]);

    return Column(
      children: [
        Text('${count.value}'),
        ElevatedButton(
          onPressed: () {
            count.value = random.nextInt(6) + 1;
            history.value = [...history.value, count.value];
          },
          child: const Text('button'),
        ),
        Text(_generateHistoryText(history.value)),
      ],
    );
  }

  String _generateHistoryText(List<int> history) {
    final buf = StringBuffer();
    buf.write('[');
    for (final value in history) {
      buf.write(value);
      buf.write(', ');
    }
    buf.write(']');
    return buf.toString();
  }
}
