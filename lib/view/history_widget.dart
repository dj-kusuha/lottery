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
      Container(
        height: 400,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${history[index]}'),
              textColor: index.isEven ? Colors.blue : Colors.orange,
              titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: history.length,
        ),
      ),
    ]);
  }
}
