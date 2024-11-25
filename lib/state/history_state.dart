import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_state.g.dart';

@riverpod
class HistoryState extends _$HistoryState {
  @override
  List<int> build() => [];

  void add(int value) {
    state = [value, ...state];
  }
}
