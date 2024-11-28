import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../state/history_state.dart';

class HistoryWidget extends HookConsumerWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyStateProvider);
    final historyText = history.join(', ');

    return Column(
      children: [
        const Text('当選履歴'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHistoryList(
              history: history,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title:
                        Text('[${history.length - index}]  ${history[index]}'),
                    textColor: index.isEven ? Colors.blue : Colors.orange,
                    titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
                itemCount: history.length,
              ),
            ),
            Column(
              children: [
                _buildHistoryList(
                  history: history,
                  child: SelectableText(historyText),
                ),
                ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: historyText));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('履歴がクリップボードにコピーされました。'),
                      ),
                    );
                  },
                  child: const Text('履歴をコピー'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHistoryList({
    required List<int> history,
    required Widget child,
  }) {
    return Container(
      height: 400,
      width: 100,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: child,
    );
  }
}
