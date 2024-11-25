import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottery/state/history_state.dart';

class HistoryWidget extends ConsumerWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyStateProvider);

    return Column(children: [
      const Text('当選履歴'),
      Text(_generateHistoryText(history)),
    ]);
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
