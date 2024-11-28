import 'dart:math' as math;

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
  final _random = math.Random();

  @override
  Roulette build() {
    return Roulette(
      isSpinning: false,
      spinningValue: null,
      result: null,
    );
  }

  Future<int> spin(int min, int max, Duration duration) async {
    state = Roulette(
      isSpinning: true,
      spinningValue: null,
      result: null,
    );

    final dateTime = DateTime.now();

    do {
      state = state.copyWith(
        spinningValue: _getRandomValue(min, max),
      );

      // 指定した時間が経過したらルーレットを停止する
      if (DateTime.now().difference(dateTime) >= duration) {
        break;
      }
      await Future.delayed(const Duration(milliseconds: 100));
    } while (state.isSpinning);

    state = Roulette(
      isSpinning: false,
      spinningValue: null,
      result: state.spinningValue,
    );

    return state.result!;
  }

  int _getRandomValue(int min, int max) {
    min = math.min(min, max);
    max = math.max(min, max);
    return _random.nextInt(max - min + 1) + min;
  }
}
