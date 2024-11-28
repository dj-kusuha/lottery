import 'dart:math' as math;

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_state.g.dart';

class Settings {
  final int min;
  final int max;
  final int rouletteSeconds;

  Settings({
    required this.min,
    required this.max,
    required this.rouletteSeconds,
  });

  Settings copyWith({
    int? min,
    int? max,
    int? rouletteSeconds,
  }) {
    return Settings(
      min: min ?? this.min,
      max: max ?? this.max,
      rouletteSeconds: rouletteSeconds ?? this.rouletteSeconds,
    );
  }
}

@riverpod
class SettingsState extends _$SettingsState {
  @override
  Settings build() {
    return Settings(min: 1, max: 6, rouletteSeconds: 3);
  }

  int setMin(int min) {
    min = math.min(min, state.max);
    state = state.copyWith(
      min: min,
    );
    return min;
  }

  int setMax(int max) {
    max = math.max(state.min, max);
    state = state.copyWith(
      max: max,
    );
    return max;
  }

  int setRouletteSeconds(int rouletteSeconds) {
    rouletteSeconds = rouletteSeconds.clamp(0, 10);
    state = state.copyWith(
      rouletteSeconds: rouletteSeconds,
    );
    return rouletteSeconds;
  }
}
