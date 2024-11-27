import 'dart:math';

import 'package:lottery/state/settings_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'roulette_state.g.dart';

class Roulette {
  final bool isSpinning;
  final int? spinningValue;
  final int? result;

  int get value => result ?? (spinningValue ?? 0);

  Roulette({
    required this.isSpinning,
    required this.spinningValue,
    required this.result,
  });

  Roulette copyWith({
    bool? isSpinning,
    int? spinningValue,
    int? result,
  }) {
    return Roulette(
      isSpinning: isSpinning ?? this.isSpinning,
      spinningValue: spinningValue ?? this.spinningValue,
      result: result ?? this.result,
    );
  }
}

@riverpod
class RouletteState extends _$RouletteState {
  final _random = Random();

  @override
  Roulette build() {
    return Roulette(
      isSpinning: false,
      spinningValue: null,
      result: null,
    );
  }

  Future<int> spin(Duration duration) async {
    state = Roulette(
      isSpinning: true,
      spinningValue: null,
      result: null,
    );

    final dateTime = DateTime.now();

    while (state.isSpinning) {
      state = state.copyWith(
        spinningValue: _getRandomValue(),
      );
      await Future.delayed(const Duration(milliseconds: 100));

      // 指定した時間が経過したらルーレットを停止する
      if (DateTime.now().difference(dateTime) >= duration) {
        break;
      }
    }

    state = Roulette(
      isSpinning: false,
      spinningValue: null,
      result: state.spinningValue,
    );

    return state.result!;
  }

  int _getRandomValue() {
    final settings = ref.watch(settingsStateProvider);
    final minValue = min(settings.max, settings.min);
    final maxValue = max(settings.max, settings.min);
    return _random.nextInt(maxValue - minValue) + minValue + 1;
  }
}
