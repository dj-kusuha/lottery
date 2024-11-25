import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_state.g.dart';

class Settings {
  final int min;
  final int max;

  Settings({
    required this.min,
    required this.max,
  });
}

@riverpod
class SettingsState extends _$SettingsState {
  @override
  Settings build() {
    return Settings(min: 1, max: 1);
  }

  void setMin(int min) {
    state = Settings(
      min: min,
      max: state.max,
    );
  }

  void setMax(int max) {
    state = Settings(
      min: state.min,
      max: max,
    );
  }
}
