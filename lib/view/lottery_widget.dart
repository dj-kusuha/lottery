import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../state/history_state.dart';
import '../state/roulette_state.dart';
import '../state/settings_state.dart';

class LotteryWidget extends ConsumerWidget {
  const LotteryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsStateProvider);
    final roulette = ref.watch(rouletteStateProvider);

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
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
                              settings.min,
                              settings.max,
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
